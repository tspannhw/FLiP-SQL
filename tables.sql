CREATE TABLE stocks
(
    symbol VARCHAR(255), 
    uuid VARCHAR(255),
    ts VARCHAR(255),
    dt	 VARCHAR(255),
   datetime VARCHAR(255),
   open VARCHAR(255), 
   close VARCHAR(255),
   high VARCHAR(255),
   volume VARCHAR(255),
   low VARCHAR(255)
)
	
  
CREATE TABLE envirosensors 
(
uuid VARCHAR(255), 
	systemtime VARCHAR(255),  
	amplitude100 VARCHAR(255), 
        amplitude500 VARCHAR(255), 
	amplitude1000 VARCHAR(255), 
	lownoise VARCHAR(255), 
	midnoise VARCHAR(255),
        highnoise VARCHAR(255), 
	amps VARCHAR(255), 
	ipaddress VARCHAR(255), 
	host VARCHAR(255), 
	host_name VARCHAR(255),
        macaddress VARCHAR(255), 
	endtime VARCHAR(255), 
	runtime VARCHAR(255), 
	starttime VARCHAR(255), 
        cpu VARCHAR(255), 
	cpu_temp VARCHAR(255), 
	diskusage VARCHAR(255), 
	memory VARCHAR(255), 
	id VARCHAR(255), 
	temperature VARCHAR(255), 
	adjtemp VARCHAR(255), 
	adjtempf VARCHAR(255), 
	temperaturef VARCHAR(255), 
	pressure VARCHAR(255), 
	humidity VARCHAR(255), 
	lux VARCHAR(255), 
	proximity VARCHAR(255), 
	oxidising VARCHAR(255), 
	reducing VARCHAR(255), 
	nh3 VARCHAR(255), 
	gasko VARCHAR(255));




CREATE TABLE iotjetsonjson 
(
	uuid VARCHAR(255), 
	camera VARCHAR(255),
	ipaddress VARCHAR(255),  
	networktime VARCHAR(255), 
        top1pct VARCHAR(255), 
	top1 VARCHAR(255), 
	cputemp VARCHAR(255), 
	gputemp VARCHAR(255),
        gputempf VARCHAR(255),
	cputempf VARCHAR(255), 
	runtime VARCHAR(255),
	host VARCHAR(255),
	filename VARCHAR(255),  
	host_name VARCHAR(255), 
        macaddress VARCHAR(255), 
	"end" VARCHAR(255), 
	te VARCHAR(255), 
	systemtime VARCHAR(255),
	cpu VARCHAR(255),
        diskusage VARCHAR(255),
	memory VARCHAR(255), 
	"id" VARCHAR(255), 
	imageinput VARCHAR(255)
);
	
