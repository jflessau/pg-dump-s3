ARG POSTGRES_IMAGE_TAG
FROM postgres:$POSTGRES_IMAGE_TAG

ARG DB_URL 
ARG FILE_PREFIX
ARG CRON_SCHEDULE
ARG PG_DUMP_ARGS

ARG BUCKET_NAME
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

RUN apt update
RUN apt-get install python3 python3-pip -y
RUN apt-get install cron -y
RUN pip3 install --upgrade pip
RUN pip3 install awscli

ADD job.sh ./job.sh
RUN chmod 755 ./job.sh

ADD entry.sh ./entry.sh
RUN chmod 755 ./entry.sh

CMD ./entry.sh

