# from https://github.com/bitsondatadev/hive-metastore/blob/master/Dockerfile
FROM bitsondatadev/hive-metastore:latest

USER root
WORKDIR /opt


ENV HADOOP_VERSION=3.2.0
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

USER root

RUN curl --output gcs-connector-hadoop3-latest.jar -L https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop3-latest.jar && \
    cp gcs-connector-hadoop3-latest.jar ${HIVE_HOME}/lib/  
    # rm -rf gcs-connector-hadoop3-latest.jar 

USER hive
# EXPOSE 9083


