#!/usr/bin/env bash

PROD_IP=${PROD_IP}

scp ./nginx.conf root@${PROD_IP}:/etc/nginx/

ssh root@${PROD_IP} << 1234567890abcdef
nginx -s reload
1234567890abcdef