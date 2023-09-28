

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