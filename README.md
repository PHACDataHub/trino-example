# Trino Example

A simple example used to gather requirements.  This example uses [Trino](https://trino.io/) - a distribueted SQL Query engine to query data stored as parquet files in Cloud Storage buckets, then visualized with [Apache Superset](https://github.com/apache/superset). 

Note - this is a work in progress, and not *yet a working example.

<!-- Distributed parallel queries with query planning and optimization. -->



## TODO 
- [X] Set up 2 projects with files in GCS bucket (parquet, excel with associated PK/ FK)
- [X] Docker compose trino locally (for now)
- [ ] Add Hive metastore in order to use GCS conector
- [ ] Set up Apache Superset - configure to use trino 
- [ ] Flush out authentication, authorization requirements and capabilities


## To run 

```
make up
```
When built 
```
docker exec -it trino trino
```

## To debug

Docker log files are written to docker-compose.log

```
docker exec -it trino /bin/sh
```
or 
```
docker exec -it hive metastore /bin/sh
```

## To tear down 
```
make down 
```

## Trino CLI commands

Here are the cli commands
https://trino.io/docs/current/client/cli.html

### Trino UI
http://localhost:8080/ 
Can view query performance and who performed the query.


### Things to note 
 
* Use case insenstive flags in properties or " " around table names if start with numbers or contain -

## Configuration

Trino uses [connectors](https://trino.io/docs/current/connector.html) to access to external data sources. Here we're using the [BigQuery connector](https://trino.io/docs/current/connector/bigquery.html), using a json credentials file for each catalog eg tebq.credentials-key.

Add configuration files for each catalog per the connector docs. When we mount the etc/catalog to /etc/trino/catalog in the container we can bypass overriding all of Trino's configuration

https://fithis2001.medium.com/manipulating-delta-lake-tables-on-minio-with-trino-74b25f7ad479
https://github.com/fithisux/experiment-with-trino-minio-hive
(look at entrypoint.sh in this one - fix file paths here and there)

open links 
https://hive.apache.org/developement/quickstart/
https://trino.io/docs/current/object-storage/file-system-cache.html
https://trino.io/docs/current/connector/metastores.html#hive-thrift-metastore
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive
https://spark.apache.org/docs/3.0.0-preview/sql-data-sources-hive-tables.html
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive
https://dataedo.com/docs/connecting-to-hive-metastore#:~:text=You%20can%20find%20all%20required,%2Fconf%2Fhive%2Dsite.
https://cwiki.apache.org/confluence/display/Hive/GettingStarted
https://stackoverflow.com/questions/50230515/hive-2-3-3-metaexceptionmessageversion-information-not-found-in-metastore
https://cwiki.apache.org/confluence/display/Hive/Hive+Schema+Tool#HiveSchemaTool-TheHiveSchemaTool
https://www.google.com/search?q=mbwa+meaning&rlz=1C1GCEV_en___CA1049&oq=mbwa+meaning&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCDMzNDJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8
* https://community.cloudera.com/t5/Support-Questions/Hive-with-Google-Cloud-Storage/m-p/211279

## Resources 

[Trino docs](docs: https://trino.io/docs/)
[Trino docker](https://trino.io/docs/current/installation/containers.html)
[ Trino Hive connector requirements ](https://trino.io/docs/current/connector/hive.html)
[Trino Github](https://github.com/trinodb/trino)

* https://trino.io/docs/current/connector/hive-gcs-tutorial.html

https://trino.io/docs/current/object-storage/file-system-gcs.html

### Authorization
* https://trino.io/docs/current/security/password-file.html
oauth2 
* https://trino.io/docs/current/security/oauth2.html

### Connect to Google Cloud Storage (with Hive Connector)

Good explaination of using hive - need HMS - hive metadata service and database
* https://trino.io/blog/2020/10/20/intro-to-hive-connector.html

## Examples
This one is the one being refered to in the article previously mentioned.  Unfortuneately this is outdated, and does not work. 
* https://github.com/njanakiev/trino-minio-docker/tree/master


Using this image for hive metastore (as we don't need the engine - using Trino)
* https://github.com/naushadh/hive-metastore (this one only has run.sh in container - no other hive-metastore files)


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

CREATE SCHEMA lkbucket.sales_data_in_gcs WITH (location = 'gs://bucket-in-lk-project/');
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

docker compoe build
docker compose up > docker-compose.log 2>&1



## DEBUGGING - not seeing bq from other project - lets see why:
https://cloud.google.com/bigquery/docs/bq-command-line-tool
(do we need to initializing your .bigqueryrc configuration file.)
(install gcloud )
gcloud auth login 
gcloud config set project phx-01hp7288p8p
enable bq api

bq ls --project_id phx-01hp7288p8p --format=pretty

bq query \
'SELECT COUNT(*) FROM iris.iris'

Okay, that works, now lets us the service account 

gcloud auth activate-service-account bq-owner@phx-01hp7288p8p.iam.gserviceaccount.com --key-file=./trino/etc/catalog/tebq.credentials-key


## What's going on with hive
When using core-site directly:
- no version error - is resulting from needing tables in the hive database

https://trino.io/docs/current/connector/metastores.html#hive-thrift-metastore
metastores - looks like we need to add properties into hive-site.xml

There's either hive-site or hive-metastore-site.xml. In our case, we're using just the metastore so that's where we'll set up metastore database properties, location, http more, etc

<property>
     <!-- https://community.hortonworks.com/content/supportkb/247055/errorjavalangunsupportedoperationexception-storage.html -->
     <name>metastore.storage.schema.reader.impl</name>
     <value>org.apache.hadoop.hive.metastore.SerDeStorageSchemaReader</value>
 </property>

 # JSON (using org.apache.hive.hcatalog.data.JsonSerDe)
# CSV (using org.apache.hadoop.hive.serde2.OpenCSVSerde)


This problem occuring is when using https://github.com/naushadh/hive-metastore the hive-metastore container only contains run.sh - nothing else get's populated (maybe error with script)

When adding the .xmls, get issue with database not having tables 

Let's start with straight image and 


There's this resource https://docs.cloudera.com/cdw-runtime/1.5.1/hive-metastore/topics/hive-configuring-hms.html

<!-- ----------------------------- -->

https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration

https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration

metastore without hive: 
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive

To enable standalone configureation for hive-metastore, modify these 2 properties to:
* metastore.task.threads.always:	org.apache.hadoop.hive.metastore.events.EventCleanerTask,org.apache.hadoop.hive.metastore.MaterializationsCacheCleanerTask
* metastore.expression.proxy:	org.apache.hadoop.hive.metastore.DefaultPartitionExpressionProxy

external datasources:
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-Option1:EmbeddingDerby

error: MetaException(message:Version information not found in metastore.)
https://cwiki.apache.org/confluence/display/Hive/Hive+Schema+Tool


#### gcs jar file 
https://aws.amazon.com/blogs/big-data/copy-large-datasets-from-google-cloud-storage-to-amazon-s3-using-amazon-emr/

https://community.cloudera.com/t5/Support-Questions/Installing-HDFS-Google-Cloud-Connector/m-p/56057#M48349

hadoop connector install https://github.com/GoogleCloudDataproc/hadoop-connectors/blob/master/gcs/INSTALL.md