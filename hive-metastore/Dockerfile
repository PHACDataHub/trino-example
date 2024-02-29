#  from https://github.com/bitsondatadev/hive-metastore/blob/master/Dockerfile

# FROM openjdk:8-jre-slim-buster 
FROM bitsondatadev/hive-metastore:latest

# WORKDIR /opt

# ENV HADOOP_VERSION=3.2.0
# ENV METASTORE_VERSION=3.0.0

# RUN apt-get update && apt-get install -y netcat curl

# ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
# ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

# RUN curl -L https://downloads.apache.org/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \
#     curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
#     curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
#     curl -L --output postgresql-42.4.0.jar https://jdbc.postgresql.org/download/postgresql-42.4.0.jar && \
#     # curl -L --output gcs-connector-hadoop3-2.2.20-shaded.jar https://github.com/GoogleCloudDataproc/hadoop-connectors/releases/download/v2.2.20/gcs-connector-hadoop3-2.2.20-shaded.jar  && \
#     cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ${HIVE_HOME}/lib/ && \
#     cp postgresql-42.4.0.jar ${HIVE_HOME}/lib/ && \
#     # cp gcs-connector-hadoop3-2.2.20-shaded.jar ${HIVE_HOME}/lib/ && \    
#     rm -rf  mysql-connector-java-8.0.19 && \
#     rm -rf  postgresql-42.4.0.jar
#     # rm -rf gcs-connector-hadoop3-2.2.20-shaded.jar && \


# COPY ./scripts/entrypoint.sh /entrypoint.sh

# RUN groupadd -r hive --gid=1000 && \
#     useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
#     chown hive:hive -R ${HIVE_HOME} && \
#     chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

# USER hive
# EXPOSE 9083

# ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
# # ENTRYPOINT ["sh", "-c", "/entrypoint.sh" && tail -f /dev/null]