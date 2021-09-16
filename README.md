# FLiP-SQL

Streaming Analytics with Apache Pulsar and Apache Flink SQL


## IoT Data Publishing into MQTT


I installed the Eclipse Paho MQTT Pyton3 client for NVIDIA XAVIER NX, Raspberry Pi 4 and Mac PowerBook.


```
pip3 install paho-mqtt
```

## Run this yourself

* You could run standalone https://pulsar.apache.org/docs/en/standalone/  https://ci.apache.org/projects/flink/flink-docs-release-1.13//docs/try-flink/local_installation/
* Run on StreamNative in the Cloud easy https://streamnative.io/en/cloud/managed/


## Links

* More Source Code https://github.com/tspannhw/FLiP-IoT
* Slides https://noti.st/tspannhw/pjnmzO/continuous-sql-with-apache-streaming-flank-and-flip
* https://github.com/tspannhw/rpi-picamera-mqtt-nifi
* https://hub.streamnative.io/protocol-handlers/mop/0.2.0
* https://github.com/eclipse/paho.mqtt-spy/releases/tag/1.0.0
* https://www.hivemq.com/mqtt-toolbox/
* https://pulsar.apache.org/docs/en/reference-cli-tools/
* https://github.com/streamnative/mop/releases/tag/v2.8.0.10
* https://pulsar.apache.org/docs/en/reference-cli-tools/
* https://pulsar.apache.org/docs/en/admin-api-topics/#create
* http://www.steves-internet-guide.com/into-mqtt-python-client/
* https://pulsar.apache.org/docs/en/sql-getting-started/
* https://github.com/morsapaes/flink-sql-pulsar
* https://flink.apache.org/2021/01/07/pulsar-flink-connector-270.html
* https://github.com/morsapaes/flink-sql-pulsar/
* https://github.com/streamnative/pulsar-flink
* https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/sqlclient/
* https://streamnative.io/en/blog/release/2021-04-20-flink-sql-on-streamnative-cloud
* https://www.youtube.com/watch?v=0BxXjEqoJlU
* https://www.youtube.com/watch?v=9ojajM7Zt0M&t=2105s
* https://docs.streamnative.io/cloud/stable/compute/flink-sql
* https://docs.streamnative.io/cloud/stable/compute/flink-sql-cookbook


## Local Pulsar Cluster REST End Points

* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/stats
* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/internalStats
* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/subscription/test-sub/position/10


## Build Pulsar Topics


## Create tenants and namespaces
```
bin/pulsar-admin tenants create stocks
bin/pulsar-admin tenants create iot
bin/pulsar-admin namespaces create stocks/inbound
bin/pulsar-admin namespaces create iot/field
```

## Create topics
```
bin/pulsar-admin topics create persistent://stocks/inbound/stocks
bin/pulsar-admin topics create persistent://stocks/inbound/stocks2
bin/pulsar-admin topics create persistent://iot/field/mqtt-1
bin/pulsar-admin topics create persistent://iot/field/mqtt-2
bin/pulsar-admin topics create persistent://iot/field/mqtt-3
bin/pulsar-admin topics create persistent://public/default/mqtt-nifi
bin/pulsar-admin topics create persistent://public/default/mqtt-go
bin/pulsar-admin topics create persistent://public/default/mqtt-python
bin/pulsar-admin topics create persistent://public/default/mqtt-rp4
bin/pulsar-admin topics create persistent://public/default/mqtt-nvidia
bin/pulsar-admin topics create persistent://public/default/mqtt-mac
bin/pulsar-admin topics create persistent://public/default/mqtt-2
bin/pulsar-admin topics create persistent://public/default/mqtt-3
bin/pulsar-admin topics create persistent://public/default/mqtt-4
bin/pulsar-admin topics create persistent://public/default/mqtt-5
bin/pulsar-admin topics create persistent://public/default/weather
```


##  Verify creation
```
bin/pulsar-admin topics list stocks/inbound/
bin/pulsar-admin topics list iot/field/
bin/pulsar-admin topics list public/default
```

## Consume Data

```
bin/pulsar-client consume -n 0 -s "subs" -p Earliest persistent://stocks/inbound/stocks
bin/pulsar-client consume "persistent://public/default/mqtt-2" -s mqtt-reader
```

## Clean up when done

Delete topics
```
bin/pulsar-admin topics delete persistent://stocks/inbound/stocks
bin/pulsar-admin topics delete persistent://stocks/inbound/stocks2
bin/pulsar-admin topics delete persistent://iot/field/mqtt-1
bin/pulsar-admin topics delete persistent://iot/field/mqtt-2
bin/pulsar-admin topics delete persistent://iot/field/mqtt-3

bin/pulsar-admin namespaces delete stocks/inbound
bin/pulsar-admin namespaces delete iot/field

bin/pulsar-admin tenants delete stocks
bin/pulsar-admin tenants delete iot
```


## Build a Table

```
CREATE TABLE scada (
	uuid STRING, 
	systemtime STRING,  
	amplitude100 DOUBLE, 
        amplitude500 DOUBLE, 
	amplitude1000 DOUBLE, 
	lownoise DOUBLE, 
	midnoise DOUBLE,
        highnoise DOUBLE, 
	amps DOUBLE, 
	ipaddress STRING, 
	host STRING, 
	host_name STRING,
        macaddress STRING, 
	endtime STRING, 
	runtime STRING, 
	starttime STRING, 
        cpu DOUBLE, 
	cpu_temp STRING, 
	diskusage STRING, 
	memory DOUBLE, 
	id STRING, 
	temperature STRING, 
	adjtemp STRING, 
	adjtempf STRING, 
	temperaturef STRING, 
	pressure DOUBLE, 
	humidity DOUBLE, 
	lux DOUBLE, 
	proximity INT, 
	oxidising DOUBLE, 
	reducing DOUBLE, 
	nh3 DOUBLE, 
	gasko STRING
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/mqtt-2',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest' 
);
```

# Or

```
CREATE TABLE scada ( uuid STRING, systemtime STRING,
amplitude100 DOUBLE, amplitude500 DOUBLE, amplitude1000 DOUBLE, 
lownoise DOUBLE, midnoise DOUBLE, highnoise DOUBLE, amps DOUBLE, 
ipaddress STRING, 
host STRING, host_name STRING, macaddress STRING, endtime STRING, 
runtime STRING, starttime STRING, cpu DOUBLE, cpu_temp STRING, 
diskusage STRING, memory DOUBLE, id STRING, temperature STRING, 
adjtemp STRING, 
adjtempf STRING, temperaturef STRING, pressure DOUBLE, humidity DOUBLE, 
lux DOUBLE, proximity INT, oxidising DOUBLE, reducing DOUBLE,
nh3 DOUBLE, gasko STRING ) 
WITH 
( 'connector' = 'pulsar', 
'topic' = 'persistent://public/default/mqtt-2', 
'value.format' = 'json',
'service-url' = 'pulsar://localhost:6650', 
'admin-url' = 'http://localhost:8080', 
'scan.startup.mode' = 'latest' 
);
```

# Other simple table

```
CREATE TABLE default_catalog.default_database.scada 
(
   uuid STRING, 
	systemtime STRING,  
	ipaddress STRING, host STRING, 
	host_name STRING, macaddress STRING, 
	endtime STRING, runtime STRING, 
	starttime STRING,
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/mqtt-2',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest'
);
```

# 

```
CREATE TABLE default_catalog.default_database.iotdata 
(
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/mqtt-2',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest'
);
```

# other table

```
CREATE TABLE default_catalog.default_database.scada2
(
  uuid STRING, systemtime STRING,
  ipaddress STRING, host STRING, host_name STRING, 
  macaddress STRING, endtime STRING, runtime STRING, starttime STRING,
 cpu_temp STRING, diskusage STRING, id STRING, 
 temperature STRING, adjtemp STRING, adjtempf STRING, temperaturef STRING, 
  proximity INT, gasko STRING,
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/mqtt-2',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest'
);
```


## Stocks Example Data

```
{"symbol":"GOOG","uuid":"d4190032-cfd7-4360-8377-39cd80635369","ts":1627655981401,"dt":1611680700000,"datetime":"2021/01/26 12:05:00","open":"2774.90991","close":"2774.94995","high":"2774.94995","volume":"1306","low":"2774.90991"}

```

## Stocks Table and Topic

```
CREATE TABLE default_catalog.default_database.stocks
(
  `symbol` STRING,
  `uuid` STRING,
  `ts` BIGINT,
  `dt` BIGINT,
  `datetime` STRING,
  `open` STRING,
  `close` STRING,
  `high` STRING,
  `volume` STRING,
  `low` STRING,
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/stocks',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest'
);
```

## Weather Table

```
CREATE TABLE default_catalog.default_database.weather
(
`location` STRING,`observation_time` STRING, `credit` STRING, 
`credit_url` STRING, `image` STRING, `suggested_pickup` STRING, 
`suggested_pickup_period` STRING,`station_id` STRING, 
`latitude` STRING, `longitude` STRING,  
`observation_time_rfc822` STRING, `weather` STRING, `temperature_string` STRING,
`temp_f` STRING, `temp_c` STRING, 
`relative_humidity` STRING, `wind_string` STRING, `wind_dir` STRING, 
`wind_degrees` STRING, `wind_mph` STRING, 
`wind_gust_mph` STRING, `wind_kt` STRING,
`wind_gust_kt` STRING, `pressure_string` STRING, `pressure_mb` STRING, 
`pressure_in` STRING, `dewpoint_string` STRING, 
`dewpoint_f` STRING, `dewpoint_c` STRING, `windchill_string` STRING,
`windchill_f` STRING, `windchill_c` STRING, `visibility_mi` STRING, 
`icon_url_base` STRING, `two_day_history_url` STRING, `icon_url_name` STRING, 
`ob_url` STRING, `disclaimer_url` STRING,
`copyright_url` STRING, `privacy_policy_url` STRING,
  publishTime TIMESTAMP(3) METADATA,
  WATERMARK FOR publishTime AS publishTime - INTERVAL '5' SECOND
) WITH (
  'connector' = 'pulsar',
  'topic' = 'persistent://public/default/weather',
  'value.format' = 'json',
  'service-url' = 'pulsar://localhost:6650',
  'admin-url' = 'http://localhost:8080',
  'scan.startup.mode' = 'earliest'
);
```


## Notes on Optional Flink Configuration

```
SET 'table.planner' = 'blink';
SET 'execution.runtime-mode' = 'streaming';
SET 'sql-client.execution.result-mode' = 'table'; 
SET 'sql-client.execution.max-table-result.rows' = '1000'; 
SET 'parallelism.default' = '1'; 
SET 'pipeline.auto-watermark-interval' = '200';
SET 'pipeline.max-parallelism' = '10';
SET 'table.exec.state.ttl' = '1000'; 
SET 'restart-strategy' = 'fixed-delay';
SET 'table.optimizer.join-reorder-enabled' = 'true';
SET 'table.exec.spill-compression.enabled' = 'true';
SET 'table.exec.spill-compression.block-size' = '128kb';
```

## Debugging Notes

Command line tools and REST end points can find a lot of things, but on my Powerbook checking all the ports is helpful.

```
lsof -i -P | grep -i "listen"
```

## Example Architecture


![Apache Pulsar + Apache Flink](https://streamnative.io/uploads/images/blogs/flinksql/4.png)

## Running Flink Cluster

./bin/start-cluster.sh
./bin/sql-client.sh embedded --library /Users/tspann/Documents/servers/flink-1.13.2/sqllib -e /Users/tspann/Documents/servers/flink-1.13.2/sql-client.yaml


## Pulsar JDBC Postgresql SINK

* https://pulsar.apache.org/docs/en/io-jdbc-sink/
* https://pulsar.apache.org/docs/en/io-quickstart/#connect-pulsar-to-postgresql

## Create an avro schema

{
  "type": "AVRO",
  "schema": "{\"type\":\"record\",\"name\":\"Test\",\"fields\":[{\"name\":\"id\",\"type\":[\"null\",\"int\"]},{\"name\":\"name\",\"type\":[\"null\",\"string\"]}]}",
  "properties": {}
}


