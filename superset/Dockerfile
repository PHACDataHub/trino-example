# Based on https://medium.com/towards-data-engineering/quick-setup-configure-superset-with-docker-a5cca3992b28
FROM apache/superset:latest

USER root

# Install database drivers https://superset.apache.org/docs/databases/installing-database-drivers/
# trino is from the docks, the sqlalcemy-trino from examples - will need to see if still needed 
RUN \
    pip install mysqlclient && \
    pip install trino && \ 
    pip install sqlalchemy-trino && \
    pip install sqlalchemy-bigquery

ENV ADMIN_USERNAME $ADMIN_USERNAME
ENV ADMIN_EMAIL $ADMIN_EMAIL
ENV ADMIN_PASSWORD $ADMIN_PASSWORD

COPY ./superset-init.sh /superset-init.sh

COPY superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset
ENTRYPOINT [ "/superset-init.sh" ]
