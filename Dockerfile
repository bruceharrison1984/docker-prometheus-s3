FROM bitnami/prometheus:latest
USER root
RUN apt-get update && apt-get install -y awscli
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
USER 1001
ENTRYPOINT [ "entrypoint.sh" ]
CMD        [ "--config.file=/opt/bitnami/prometheus/conf/prometheus.yml", \
             "--storage.tsdb.path=/opt/bitnami/prometheus/data", \
             "--log.format=json", \
             "--web.console.libraries=/opt/bitnami/prometheus/conf/console_libraries", \
             "--web.console.templates=/opt/bitnami/prometheus/conf/consoles" ]