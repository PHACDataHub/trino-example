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
docker compose build && docker compose up > docker-compose.log 2>&1
```

When built (view docker-compose.log), in another terminal launch Trino; 
```
docker exec -it trino trino
```

### Trino CLI commands

Here are the cli commands
https://trino.io/docs/current/client/cli.html

### Trino UI
http://localhost:8080/ 
Can view query performance and who performed the query.

### To debug

Docker log files are written to docker-compose.log

```
docker exec -it trino /bin/sh
```
or 
```
docker exec -it hive metastore /bin/sh
```
### Things to note 
 
* Use case insenstive flags in properties or " " around table names if start with numbers or contain -
## To tear down 
```
docker compose down -v
```


## Configuration

### Trino

Trino uses [connectors](https://trino.io/docs/current/connector.html) to access external data sources. With this example, we're using the [BigQuery connector](https://trino.io/docs/current/connector/bigquery.html) using a json GCP sevice account credentials file (for now) for each catalog (eg each connection). We're also using the [Hive connector](https://trino.io/docs/current/connector/hive.html) in order to access files in google cloud storage as there's no native GCS connecter for Trino. 

Configuration files for each catalog are stored in trino/etc/catalog (per the connector docs). When we mount this folder to /etc/trino/catalog location in the container we can bypass overriding all of Trino's configuration.

### Hive Metastore(HMS) 

(Provides a central repository of metadata )

For Trino, we're using the Hive metastore service rather than the full Hive distribution. See [this article](https://trino.io/blog/2020/10/20/intro-to-hive-connector.html) for an explaination why we're using just the metastore (and database).  Trino uses the hive connector for google cloud storage - which requires a little set up.

(Hive does have an internal database (Derby) you could use, but here's we're using MariaDB based on the example.) 

Here are the docs for hive metastore:
https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive

To enable standalone configuration for hive-metastore, modify these 2 properties in metastore-site.xml:
* metastore.task.threads.always:	org.apache.hadoop.hive.metastore.events.EventCleanerTask,org.apache.hadoop.hive.metastore.MaterializationsCacheCleanerTask
* metastore.expression.proxy:	org.apache.hadoop.hive.metastore.DefaultPartitionExpressionProxy

In order for this to work, we need HDFS(hadoop distributed file system), with [GCS connector](https://github.com/GoogleCloudDataproc/hadoop-connectors/blob/master/gcs/INSTALL.md)

## Setup 

Configure access to google cloud storage for trino:

1. Set up service account for google cloud storage
2. Mount this to the hive-metastore 
3. Use the mounted hive-metastore location and indicate path in etc/catalog/bucket.properties (https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html)

4. Confgure hive GCS connector/ access to google cloud storage 

- add core-site.xml file (** to add reference) and mount to /opt/hive/conf in hive-metastore container
* [add permisions to core-site](https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html#:~:text=Make%20sure%20Hive%20GCS%20configuration%20includes%20a%20fs.gs.reported.permissions%20property%20with%20a%20value%20of%20777.)
* [add gs settings to core-site]
- add [hadoop and connector](https://community.cloudera.com/t5/Support-Questions/Installing-HDFS-Google-Cloud-Connector/td-p/56053)

5. docker compose up

### [Superset](https://github.com/apache/superset) 

Using these resources:
* [releasese](https://github.com/apache/superset/releases)
* [quickstart](https://superset.apache.org/docs/quickstart)
* https://medium.com/towards-data-engineering/quick-setup-configure-superset-with-docker-a5cca3992b28

Note - Superset comes with MYSQL database driver, but for any other database connection, you will need to pip install the database driver in the Superset Dockerfile:
* database drivers https://superset.apache.org/docs/databases/installing-database-drivers/

Log into Superset UI:
```
localhost:8088

username: admin
password: admin
```

Connect to Trino (connect to database) (here are the [docs](* https://superset.apache.org/docs/databases/trino/), but use below instead)
- use the trino connector and for the URI, use:
```
trino://trino@trino:8080/{catalog_name}
```

## Resources 

### Trino
* [Trino docs](docs: https://trino.io/docs/)
* [Trino docker](https://trino.io/docs/current/installation/containers.html)
* [Trino Hive connector requirements ](https://trino.io/docs/current/connector/hive.html)
* [Trino Github](https://github.com/trinodb/trino)
* https://trino.io/docs/current/connector/hive-gcs-tutorial.html
* https://trino.io/docs/current/object-storage/file-system-gcs.html

Trino - connecting to GCS
* https://trino.io/docs/current/connector/hive-gcs-tutorial.html
* https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html

#### Trino Authorization
* https://trino.io/docs/current/security/password-file.html
oauth2 
* https://trino.io/docs/current/security/oauth2.html

### Hive Metastore
Good explaination of using hive - need hive metadata service and database (and Hadoop distributed filesystem)
(we're using this example as a starting point this one)
* https://trino.io/blog/2020/10/20/intro-to-hive-connector.html

Hive quickstart docker image: 
* https://hive.apache.org/developement/quickstart/ 

Running metastore without Hive
* https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration#AdminManualMetastore3.0Administration-RunningtheMetastoreWithoutHive

Configuring hive metastore service
* https://docs.cloudera.com/cdw-runtime/1.5.1/hive-metastore/topics/hive-configuring-hms.html

We *may need these properties
* JSON (using org.apache.hive.hcatalog.data.JsonSerDe)
* CSV (using org.apache.hadoop.hive.serde2.OpenCSVSerde)

### Connect to Google Cloud Storage (with Hive Connector)

Configuration changes for gcs
* https://community.cloudera.com/t5/Community-Articles/Accessing-Google-Cloud-Storage-via-HDP/ta-p/248754 
* https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-other-options.html ** 
* https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html
Google: Installing the Cloud Storage connector 
* https://cloud.google.com/dataproc/docs/concepts/connectors/install-storage-connector

Using this one 
* https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-cluster-config.html

HortonWorks: Working with Google Cloud Storage
* https://docs.hortonworks.com/HDPDocuments/HDP3/HDP-3.1.0/bk_cloud-data-access/content/gcp-get-started.html

Cloudera: Configuring Google Cloud Storage Connectivity
* https://www.cloudera.com/documentation/enterprise/latest/topics/admin_gcs_config.html

Setting up gcs as warehouse directory
* https://cloud.google.com/dataproc-metastore/docs/hive-metastore
* https://community.cloudera.com/t5/Community-Articles/Accessing-Google-Cloud-Storage-via-HDP/ta-p/248754
