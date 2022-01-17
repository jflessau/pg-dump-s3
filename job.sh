#!/bin/sh

# pull db dump
pg_dump ${PG_DUMP_ARGS:-} ${DB_URL} > dump.sql;

# upload dump to s3
aws s3 cp ./dump.sql s3://${BUCKET_NAME}/"$FILE_PREFIX$(date +"%Y-%m-%d-%H:%M:%S")".sql && rm ./dump.sql