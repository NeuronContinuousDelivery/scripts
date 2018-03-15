#!/usr/bin/env bash

#env
NAME=${NAME}
VERSION=${VERSION}
PORT=${PORT}
WEB_PATH=${WEB_PATH}

#image var
IMAGE_NAME=${NAME}:${VERSION}
CONTAINER_NAME=${NAME}
TAR=${NAME}_${VERSION}.tar

#build
if  [  -d "build" ]; then
  rm -rf build
fi
PUBLIC_URL=/web/${WEB_PATH} npm run build

#docker clean
if  [ -d "_output" ]; then
  rm -rf _output
fi
mkdir ./_output
docker stop ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}
#docker rmi -f ${IMAGE_NAME} #cache

#docker build
docker build -t ${IMAGE_NAME} -f ./Dockerfile \
--build-arg WEB_PATH=${WEB_PATH} \
.

docker run -d -p ${PORT}:8080 --name=${CONTAINER_NAME} ${IMAGE_NAME}