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



