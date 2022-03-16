#!/bin/sh

# fill crontab.txt
echo "DB_URL=$DB_URL" >> ./crontab.txt
echo "PG_DUMP_ARGS=${PG_DUMP_ARGS:-\"\"}" >> ./crontab.txt
echo "BUCKET_NAME=\"$BUCKET_NAME\"" >> ./crontab.txt
echo "FILE_PREFIX=${FILE_PREFIX:-\"\"}" >> ./crontab.txt
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> ./crontab.txt
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> ./crontab.txt
echo "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-\"\"}" >> ./crontab.txt
echo "# m h dom mon dow command" >> ./crontab.txt
echo "$CRON_SCHEDULE . /etc/profile; /job.sh > /dev/stdout" >> ./crontab.txt

# load crontab.txt
./usr/bin/crontab ./crontab.txt

# start cron
crond -f -l 2
