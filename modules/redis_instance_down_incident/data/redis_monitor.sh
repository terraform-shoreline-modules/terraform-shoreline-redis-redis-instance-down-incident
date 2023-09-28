

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