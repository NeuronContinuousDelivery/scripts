#!/usr/bin/env bash

PORT=${PORT}
REACT_APP_WEB_PATH=${REACT_APP_WEB_PATH}
REACT_APP_WEB_HOST=http://127.0.0.1:8080

PORT=${PORT} \
REACT_APP_WEB_HOST=${REACT_APP_WEB_HOST} \
REACT_APP_WEB_PATH=${REACT_APP_WEB_PATH} \
npm start