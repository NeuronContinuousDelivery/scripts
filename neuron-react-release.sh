#!/usr/bin/env bash

#env
NAME=${NAME}
VERSION=${VERSION}
PORT=${PORT}
PUBLIC_URL=https://neuron-public.oss-cn-shanghai.aliyuncs.com/web/${NAME}
REACT_APP_WEB_PATH=${REACT_APP_WEB_PATH}

#sys env
PROD_IP=${PROD_IP}
REACT_APP_WEB_HOST="http://106.14.204.11:8080"

#image var
IMAGE_NAME=${NAME}:${VERSION}
CONTAINER_NAME=${NAME}
TAR=${NAME}_${VERSION}.tar

#build
if  [  -d "build" ]; then
  rm -rf build
fi

PUBLIC_URL=${PUBLIC_URL} \
REACT_APP_WEB_PATH=${REACT_APP_WEB_PATH} \
REACT_APP_WEB_HOST=${REACT_APP_WEB_HOST} \
npm run build

#upload static files to aliyun oss
ossutilmac64 cp -f -r ./build/ oss://neuron-public/web/${NAME}/ --exclude *.js.map

#docker build
docker build -t ${IMAGE_NAME} -f ./Dockerfile .

#docker save
if  [ -d "_output" ]; then
  rm -rf _output
fi
mkdir ./_output
docker save ${IMAGE_NAME} -o ./_output/${TAR}

#deploy
scp ./_output/${TAR} root@${PROD_IP}:~/files/

#remote restart
ssh root@${PROD_IP} << 1234567890abcdef
cd ~/files
docker stop ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
docker rmi -f ${IMAGE_NAME}
docker load -i ${TAR}
docker run -d -p ${PORT}:8080 --name=${CONTAINER_NAME} ${IMAGE_NAME} >${CONTAINER_NAME}.txt
sleep 1
cat ${CONTAINER_NAME}.txt |xargs -I ASDFGHJKL docker logs ASDFGHJKL
exit
1234567890abcdef

sleep 1
curl http://${PROD_IP}:${PORT}
sleep 1

echo done!