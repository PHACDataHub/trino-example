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

<!-- ## Run with connectors 

Add files in etc/trino/catalog and run:
```
docker run --name trino -d -p 8080:8080 --volume $PWD/etc/catalog:/etc/trino/catalog trinodb/trino
```
then 
```
docker exec -it trino trino
```
or if to debug
```
docker exec -it trino bash
 ``` -->


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


Using this part/ image for just metastore 
* https://github.com/naushadh/hive-metastore

GCS 
* https://trino.io/docs/current/connector/hive-gcs-tutorial.html
* https://ta.thinkingdata.cn/trino-docs/connector/hive-gcs-tutorial.html

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


