# From https://medium.com/towards-data-engineering/quick-setup-configure-superset-with-docker-a5cca3992b28
FROM apache/superset:latest

USER root

# Install database drivers https://superset.apache.org/docs/databases/installing-database-drivers/
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
# # # From here https://github.com/dgkatz/trino-hive-superset-docker - not using yet! 
# # FROM apache/superset:latest
# # # Switching to root to install the required packages
# # USER root
# # # Example: installing the MySQL driver to connect to the metadata database
# # # if you prefer Postgres, you may want to use `psycopg2-binary` instead
# # RUN pip install mysqlclient
# # RUN pip install sqlalchemy-trino
# # # Switching back to using the `superset` user

# # COPY --chown=superset superset_config.py /app/
# # ENV SUPERSET_CONFIG_PATH /app/superset_config.py

# # USER superset


# #  Modified from docker instructions from  https://superset.apache.org/docs/quickstart
# # ENV SUPERSET_VERSION=3.1.1

# # FROM apache/superset:$SUPERSET_VERSION
# FROM apache/superset:3.1.1
# # Set environment variables
# # ENV SUPERSET_SECRET_KEY=$(openssl rand -base64 42)
# ENV SUPERSET_SECRET_KEY=094y599c8y3rn298y98y9ndy928y9y9yccn98q0ouwa89023u4
# ENV TALISMAN_ENABLED=False

# # Copy initialization script
# COPY init.sh /usr/local/bin/init.sh
# COPY create_admin.py /usr/local/bin/create_admin.py
# # COPY init.sh /init.sh
# # RUN chmod +x /init.sh

# # Expose Superset port
# EXPOSE 8088

# # Start Superset and run initialization script
# ENTRYPOINT ["/init.sh"]