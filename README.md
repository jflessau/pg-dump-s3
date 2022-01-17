# pg-dump-s3

Dockerfile for scheduled postgres dumps and upload to s3.

## Usage

### Building the image

```bash
docker build --build-arg "POSTGRES_IMAGE_TAG=13.5" -t pg_dump_s3 .
```

It takes `POSTGRES_IMAGE_TAG` as a build arg so that the postgres version in this image can match the version you want a backup from.
Thats necessary because `pg_dump` works best on databases with the same postgres version.

See the _Tested images_ section for a list of images that should work.

### Starting a Container

```bash
docker run \
  -e DB_URL=<your_db_url> \
  -e PG_DUMP_ARGS=<pg_dump_args>
  -e BUCKET_NAME=<your_bucket_name> \
  -e FILE_PREFIX=<file_prefix> \
  -e AWS_ACCESS_KEY_ID=<your_aws_key_id> \
  -e AWS_SECRET_ACCESS_KEY=<your_aws_secret_key> \
  -e AWS_DEFAULT_REGION=aws_region=<your_aws_region> \
  -e CRON_SCHEDULE=<crontab_schedule> \
  pg_dump_s3
```

### Env Vars

| Name                  | Example Value                                 | Required |
| --------------------- | --------------------------------------------- | -------- |
| DB_URL                | `postgres:://user:pwd@localhost:5432/db_name` | yes      |
| PG_DUMP_ARGS          | `--schema=public`                             | no       |
| BUCKET_NAME           | `pg_dump_bucket`                              | yes      |
| FILE_PREFIX           | `my_db_dump-`                                 | no       |
| AWS_ACCESS_KEY_ID     | `123456789`                                   | yes      |
| AWS_SECRET_ACCESS_KEY | `ASDFGHJKL`                                   | yes      |
| AWS_DEFAULT_REGION    | `eu-central-1`                                | yes      |
| CRON_SCHEDULE         | `* * * * *`                                   | yes      |

See [https://crontab.guru/examples.html](https://crontab.guru/examples.html) for more `CRON_SCHEDULE` example values.

## Tested Postgres Images

It uses official postgres images from [https://hub.docker.com/\_/postgres](https://hub.docker.com/_/postgres).

The dockerfile allows to specify the image tag with a build arg, e.g. `POSTGRES_IMAGE_TAG=14.1`.
It's not granted that it'll work with all image tags (e.g. `*-alpine` images don't work).

I tested the dockerfile with a few tags.
Feel free to open a PR if you want to edit the list.

| Image Tag       | Works |
| --------------- | ----- |
| `14.1`          | ✅    |
| `14.1-bullseye` | ✅    |
| `14.1-alpine`   | 🚫    |
| `13.5`          | ✅    |
| `12.9`          | ✅    |
| `11.14`         | ✅    |
| `10.19`         | ✅    |
| `9.6`           | ✅    |
