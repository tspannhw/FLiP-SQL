# FLiP-SQL

Streaming Analytics with Apache Pulsar and Apache Flink SQL

# IoT Data Publishing into MQTT

I installed the Eclipse Paho MQTT Pyton3 client for NVIDIA XAVIER NX, Raspberry Pi 4 and Mac PowerBook.


```
pip3 install paho-mqtt
```

# Run this yourself

* You could run standalone https://pulsar.apache.org/docs/en/standalone/  https://ci.apache.org/projects/flink/flink-docs-release-1.13//docs/try-flink/local_installation/
* Run on StreamNative in the Cloud easy https://streamnative.io/en/cloud/managed/


# Links

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

# Local Pulsar Cluster REST End Points

* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/stats
* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/internalStats
* http://localhost:8080/admin/v2/persistent/public/default/mqtt-1/subscription/test-sub/position/10


# Build Pulsar Topics

Create Logical Components
-------------------------

Create tenants and namespaces
```
bin/pulsar-admin tenants create stocks
bin/pulsar-admin tenants create iot
bin/pulsar-admin namespaces create stocks/inbound
bin/pulsar-admin namespaces create iot/field
```

Create topics
```
bin/pulsar-admin topics create persistent://stocks/inbound/stocks
bin/pulsar-admin topics create persistent://stocks/inbound/stocks2
bin/pulsar-admin topics create persistent://iot/field/mqtt-1
bin/pulsar-admin topics create persistent://iot/field/mqtt-2
bin/pulsar-admin topics create persistent://iot/field/mqtt-3

```

Verify creation
```
bin/pulsar-admin topics list stocks/inbound/
bin/pulsar-admin topics list iot/field/
```

```
bin/pulsar-client consume -n 0 -s "subs" -p Earliest persistent://stocks/inbound/stocks
bin/pulsar-client consume "persistent://public/default/mqtt-1" -s mqtt-reader
```

# Clean up when done

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


# Build a Table

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


