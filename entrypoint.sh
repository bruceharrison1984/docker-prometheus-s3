#!/bin/sh
set -e

rm /opt/bitnami/prometheus/conf/prometheus.yml -f
if [ -z ${S3_CONFIG_LOCATION} ]; then
  echo "S3_CONFIG_LOCATION environment variable must be set to an S3 location"
  exit 1
fi

echo "Retrieving remote prometheus config: '${S3_CONFIG_LOCATION}'"
aws s3 cp ${S3_CONFIG_LOCATION} /opt/bitnami/prometheus/conf/prometheus.yml

/opt/bitnami/prometheus/bin/prometheus $@