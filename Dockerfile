# ARG POSTGRES_IMAGE_TAG
# FROM postgres:$POSTGRES_IMAGE_TAG as postgres

FROM alpine

ARG DB_URL 
ARG FILE_PREFIX
ARG CRON_SCHEDULE
ARG PG_DUMP_ARGS

ARG BUCKET_NAME
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

RUN apk update
RUN apk add python3 
RUN apk add py3-pip
RUN pip3 install --upgrade pip
RUN pip3 install awscli
RUN apk add postgresql-client-11

ADD job.sh ./job.sh
RUN chmod 755 ./job.sh

ADD entry.sh ./entry.sh
RUN chmod 755 ./entry.sh

CMD ./entry.sh

