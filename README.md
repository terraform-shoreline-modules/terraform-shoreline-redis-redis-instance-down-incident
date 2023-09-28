
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis instance down incident
---

A Redis instance down incident refers to a situation where the Redis server, which is a popular open-source in-memory data structure store, is not functioning or accessible. This can cause interruption in the service and impact the performance of applications that rely on Redis for caching or data storage. Typically, this type of incident is considered high urgency and requires immediate attention from the responsible team to investigate, diagnose, and resolve the issue.

### Parameters
```shell
export PATH_TO_REDIS_LOG_FILE="PLACEHOLDER"
```

## Debug

### Check if Redis service is running
```shell
systemctl status redis
```

### Check Redis logs for any errors
```shell
journalctl -u redis | tail
```

### Check Redis configuration file for any issues
```shell
redis-cli config get *
```

### Check Redis server connectivity
```shell
redis-cli ping
```

### Check Redis memory usage
```shell
redis-cli info memory
```

### Check Redis CPU usage
```shell
redis-cli info cpu
```

### Check Redis replication status
```shell
redis-cli info replication
```

### Check Redis keyspace status
```shell
redis-cli info keyspace
```

### Redis server might have been facing heavy load or high traffic, causing it to crash or become unresponsive.
```shell


if systemctl is-active --quiet redis.service; then

  echo "Redis server is running."

else

  echo "Redis server is not running."

fi





if grep -q "ERROR" /var/log/redis/redis.log; then

  echo "Redis server has errors in logs."

fi



if grep -q "CRASH" /var/log/redis/redis.log; then

  echo "Redis server has crashed."

fi





if grep -q "used_memory_peak" /var/log/redis/redis.log; then

  echo "Redis server has high memory usage."

fi



if grep -q "total_commands_processed" /var/log/redis/redis.log; then

  echo "Redis server has high command processing rate."

fi





if grep -q "cpu" /proc/stat; then

  echo "System CPU usage is high."

fi



if free | awk 'NR==2{printf "%.2f\n", $3/$2*100}' | grep -q "^[7-9][0-9]\|[1-9][0-9][0-9]"; then

  echo "System memory usage is high."

fi



if df | awk '$NF=="/"{printf "%.2f\n", $5}' | grep -q "^[7-9][0-9]\|[1-9][0-9][0-9]"; then

  echo "System disk usage is high."

fi





if netstat -s | grep -q "segments retransmitted"; then

  echo "Network traffic is high and causing retransmissions."

fi


```

## Repair

### Check the Redis server logs to understand the root cause of the issue.
```shell


#!/bin/bash



# Set the log file path

LOG_FILE=${PATH_TO_REDIS_LOG_FILE}



# Check if the log file exists

if [ -f "$LOG_FILE" ]; then

    # Print the last 10 lines of the log file

    tail -n 10 "$LOG_FILE"

else

    echo "Error: Redis log file not found!"

fi


```