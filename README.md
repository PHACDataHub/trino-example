# Trino Example

A simple example used to gather requirements.  This example uses [Trino](https://trino.io/) SQL Query engine to query data stored as parquet files in Cloud Storage buckets, then visualized with [Apache Superset](https://github.com/apache/superset). 

Note - this is a work in progress, and not *yet a working example.

<!-- "Trino is not a database with storage, rather, it simply queries data where it lives. When using Trino, storage and compute are decoupled and can be scaled independently. Trino represents the compute layer, whereas the underlying data sources represent the storage layer." \
--https://trino.io/episodes/20.html

Distributed parallel queries with query planning and optimization. -->



## TODO 
- [ ] Set up 2 projects with files in GCS bucket (parquet, excel with associated PK/ FK)
- [ ] Docker compose trino locally (for now)
- [ ] Add Hive metastore in order to use GCS conector
- [ ] Set up Apache Superset - configure to use trino 
- [ ] Flush out authentication, authorization requirements and capabilities


## To run 
<!-- ```
docker run --name trino -d -p 8080:8080 trinodb/trino
```
when docker ps results in healthy, 
```
docker exec -it trino trino
```
when done, 
```
quit
docker stop trino
docker rm trino
```

OR -->
```
docker compose up 
```

Once up and running to determine the container ID for trino: 

```
docker ps
```
Pick out ID for trino/trinoDB and run the trino CLI:

```
docker exec -it <ID> trino
```

To tear down 
```
docker compose down -v 
```
## Trino CLI commands

Here are the cli commands
https://trino.io/docs/current/client/cli.html

## UI
http://localhost:8080/ 
Can view query performance and who performed the query.


## Things to note 
 
* Use case insenstive flags in properties or " " around table names if start with numbers or contain -
<!-- 
## Thoughts 
* show using R or python Trino libraries -->


## Resources 
Connectors - https://trino.io/docs/current/connector.html


https://trino.io/download.html
https://trino.io/docs/current/installation/containers.html
https://github.com/trinodb
https://github.com/trinodb/trino
https://towardsdatascience.com/getting-started-with-trino-query-engine-dc6a2d027d5

docs: https://trino.io/docs/


### Authorization
https://trino.io/docs/current/security/password-file.html
oauth2 
https://trino.io/docs/current/security/oauth2.html

### Connect to Google Cloud Storage (with Hive Connector)

Good explaination of using hive - need HMS - hive metadata service and database
* https://trino.io/blog/2020/10/20/intro-to-hive-connector.html

Example repo basing this on 
* https://github.com/njanakiev/trino-minio-docker/tree/master


Using this image for hive metastore (as we don't need the engine - using Trino)
* https://github.com/naushadh/hive-metastore


Another example 
https://medium.com/@adamrempter/running-spark-3-with-standalone-hive-metastore-3-0-b7dfa733de91
https://github.com/arempter/hive-metastore-docker

- https://hive.apache.org/developement/quickstart/ (derby db)
docker run -d -p 9083:9083 --env SERVICE_NAME=metastore --name metastore-standalone apache/hive:${HIVE_VERSION}

```
docker run -d -p 9083:9083 --env SERVICE_NAME=metastore --name metastore-standalone apache/hive:3.1.3
````

Configuration changes for gcs
* https://community.cloudera.com/t5/Community-Articles/Accessing-Google-Cloud-Storage-via-HDP/ta-p/248754 
* https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-other-options.html ** THIS IS GOOD!

#### Hive METASTORE configuration


*** standalone mestastore https://stackoverflow.com/questions/48932907/setup-standalone-hive-metastore-service-for-presto-and-aws-s3
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive

 From https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html
Google: Installing the Cloud Storage connector 
* https://cloud.google.com/dataproc/docs/concepts/connectors/install-storage-connector

Using this one 
https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-cluster-config.html

HortonWorks: Working with Google Cloud Storage
* https://docs.hortonworks.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-get-started.html

Cloudera: Configuring Google Cloud Storage Connectivity
* https://www.cloudera.com/documentation/enterprise/latest/topics/admin_gcs_config.html

GCS 
* https://trino.io/docs/current/connector/hive-gcs-tutorial.html
* https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html

    setting up gcs as warehouse directory
* https://cloud.google.com/dataproc-metastore/docs/hive-metastore
* https://community.cloudera.com/t5/Community-Articles/Accessing-Google-Cloud-Storage-via-HDP/ta-p/248754

CREATE SCHEMA bucket.sales_data_in_gcs WITH (location = 'gs://bucket-in-lk-project/');
CREATE SCHEMA hive.gcs_export WITH (location = 'gs://bucket-in-lk-project/health_facilities_bc.csv');

USE hive.default;

-- create table
CREATE TABLE orders (
     orderkey bigint,
     custkey bigint,
     orderstatus varchar(1),
     totalprice double,
     orderdate date,
     orderpriority varchar(15),
     clerk varchar(15),
     shippriority integer,
     comment varchar(79)
) WITH (
     external_location = 'gs://bucket-in-lk-project/',
     format = 'ORC' -- or 'PARQUET'
);

Other
* https://hive.apache.org/developement/quickstart/

<!-- ```
export GOOGLE_APPLICATION_CREDENTIALS=$(cat ./sa-gcs-key.json | base64)
``` -->

### Apache Superset (not here yet)
* https://superset.apache.org/docs/installation/
* installing-superset-using-docker-compose/
* https://github.com/apache/superset
* https://superset.apache.org/docs/databases/trino/
* https://www.restack.io/docs/superset-knowledge-apache-superset-trino-integration
* https://www.restack.io/docs/superset-knowledge-superset-trino-docker-guide
* https://github.com/sairamkrish/trino-superset-demo
* https://superset.apache.org/docs/databases/trino/

example (3 years old)
* https://github.com/dgkatz/trino-hive-superset-docker

* https://github.com/sairamkrish/trino-superset-demo  with 
* https://sairamkrish.medium.com/visualize-parquet-files-with-apache-superset-using-trino-or-prestosql-511f18a37e3b

(https://www.youtube.com/watch?v=0NHUs-TERtk, https://www.youtube.com/watch?v=Dw_al_26F6o)


Monday: 
ot exception: org.apache.hadoop.fs.UnsupportedFileSystemException No FileSystem for scheme "gs"
******** https://community.cloudera.com/t5/Support-Questions/Installing-HDFS-Google-Cloud-Connector/td-p/56053
install hadoop

----------------------------------------------------------------------------

Setting up 

See [this article](https://trino.io/blog/2020/10/20/intro-to-hive-connector.html) for an explaination why we're using just the hive-metastore.  Trino is being used in place of hive, but using the hive connector for google cloud storage - which requires a little set up.

Configure access to google cloud storage for trino:

1. Set up service account for google cloud storage
2. Mount this to the hive-metastore 
3. Use the mounted hive-metastore location and indicate path in etc/catalog/bucket.properties (https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html)

This example is using derby data warehouse to store hive metadata (schemas, etc) - schemas do not persist with this option, if that's the case, set up a database or volume.

4. Confgure hive GCS connector/ access to google cloud storage 

- add core-site.xml file** reference and mount to /opt/hive/conf in hive-metastore container
* [add permisions to core-site](https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html#:~:text=Make%20sure%20Hive%20GCS%20configuration%20includes%20a%20fs.gs.reported.permissions%20property%20with%20a%20value%20of%20777.)
* [add gs settings to core-site]
- add [hadoop and connector](https://community.cloudera.com/t5/Support-Questions/Installing-HDFS-Google-Cloud-Connector/td-p/56053)

