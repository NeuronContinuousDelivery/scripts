#!/usr/bin/env bash

PORT=${PORT}
PROD_IP=${PROD_IP}
NAME=${NAME}
VERSION=${VERSION}

#ENV in Dockerfile
ENV=PROD
DB="root:123456@tcp(106.14.204.11:3307)"

#image vars
IMAGE_NAME=${NAME}:${VERSION}
CONTAINER_NAME=${NAME}
TAR=${NAME}_${VERSION}.tar

API_GATEWAY=${PROD_IP}:8080

#clean
if  [ ! -d "_output" ]; then
  mkdir _output
fi
rm -rf ./_output/release
mkdir ./_output/release

cp ~/work/neuron/src/github.com/NeuronContinuousDelivery/scripts/Dockerfile ./_output/release

#go build
GOOS=linux GOARCH=amd64 go build -o ./_output/release/neuron-agent .

#docker image
docker build -t ${IMAGE_NAME} -f ./_output/release/Dockerfile \
--build-arg ENV=${ENV} \
--build-arg DB=${DB} \
--build-arg API_GATEWAY=${API_GATEWAY} \
.

#docker tar
docker save ${IMAGE_NAME} -o ./_output/release/${TAR}

#deploy
scp ./_output/release/${TAR} root@${PROD_IP}:~/files/

#remote restart
ssh root@${PROD_IP} << 1234567890abcdef
cd ~/files
docker stop ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
docker rmi -f ${IMAGE_NAME}
docker load -i ${TAR}
docker run -d -p ${PORT}:8080 --name=${CONTAINER_NAME} ${IMAGE_NAME} >${CONTAINER_NAME}.txt
sleep 5
cat ${CONTAINER_NAME}.txt |xargs -I ASDFGHJKL docker logs ASDFGHJKL
exit
1234567890abcdef

echo done!