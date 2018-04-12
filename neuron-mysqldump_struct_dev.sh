#!/usr/bin/env bash

chmod -R 777 .
DB_NAME=${DB_NAME}
mysqldump -h 127.0.0.1 -P 3307 -u root -p${DB_PWD_DEV} -d ${DB_NAME} > ${DB_NAME}.sql
mysql-orm-gen -sql_file=./${DB_NAME}.sql -orm_file=./${DB_NAME}-gen.go -package_name=${DB_NAME}_db