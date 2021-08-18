# FLiP-SQL
Streaming Analytics with Apache Pulsar and Apache Flink SQL


# Build a Table

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


# Or

CREATE TABLE scada ( uuid STRING, systemtime STRING,
amplitude100 DOUBLE, amplitude500 DOUBLE, amplitude1000 DOUBLE, lownoise DOUBLE, midnoise DOUBLE, highnoise DOUBLE, amps DOUBLE, ipaddress STRING, host STRING, host_name STRING, macaddress STRING, endtime STRING, runtime STRING, starttime STRING, cpu DOUBLE, cpu_temp STRING, diskusage STRING, memory DOUBLE, id STRING, temperature STRING, adjtemp STRING, adjtempf STRING, temperaturef STRING, pressure DOUBLE, humidity DOUBLE, lux DOUBLE, proximity INT, oxidising DOUBLE, reducing DOUBLE, nh3 DOUBLE, gasko STRING ) WITH ( 'connector' = 'pulsar', 'topic' = 'persistent://public/default/mqtt-2', 'value.format' = 'json', 'service-url' = 'pulsar://localhost:6650', 'admin-url' = 'http://localhost:8080', 'scan.startup.mode' = 'latest' );

# Other simple table

CREATE TABLE default_catalog.default_database.scada 
(
   uuid STRING, 
	systemtime STRING,  
	ipaddress STRING, host STRING, host_name STRING, macaddress STRING, endtime STRING, runtime STRING, starttime STRING,
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


# 

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

# other table

CREATE TABLE default_catalog.default_database.scada2
(
  uuid STRING, systemtime STRING,
  ipaddress STRING, host STRING, host_name STRING, macaddress STRING, endtime STRING, runtime STRING, starttime STRING,
 cpu_temp STRING, diskusage STRING, id STRING, temperature STRING, adjtemp STRING, adjtempf STRING, temperaturef STRING, 
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



## Stocks

{"symbol":"GOOG","uuid":"d4190032-cfd7-4360-8377-39cd80635369","ts":1627655981401,"dt":1611680700000,"datetime":"2021/01/26 12:05:00","open":"2774.90991","close":"2774.94995","high":"2774.94995","volume":"1306","low":"2774.90991"}

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

## Notes


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



