#!/bin/bash

# Log file path
LOG_FILE="/var/lib/docker/containers/f7d86260910af4248e23dfd5628a2c058c05ed1954ae4e622ea5f5cc7524bc13/f7d86260910af4248e23dfd5628a2c058c05ed1954ae4e622ea5f5cc7524bc13-json.log"
RESTART_LOG="/root/restart-script/restart.log"

# Function to check for errors and restart Docker containers
check_and_restart() {
    # Read the last line from the log file
    last_line=$(tail -n 1 $LOG_FILE)

    # Check if the word 'error' is in the last line
    if echo "$last_line" | grep -i "error" >/dev/null; then
        # Find the last 'info' line before the 'error' line
        last_info=$(tac $LOG_FILE | grep -m 1 -i "info")

        # Log the last 'info' and the restart event
        echo "Last Info: $last_info" >> $RESTART_LOG
        echo "Node encountered errors. Restarting at $(date)" >> $RESTART_LOG
        
        # Clear logs
        TIME = date "+%Y%m%d%H%M%S"
        cp $LOG_FILE /root/restart-script/archive/f7d86260910af4248e23dfd5628a2c058c05ed1954ae4e622ea5f5cc7524bc13-$TIME-json.log
        rm $LOG_FILE
        
        # Restart the Docker containers
        docker restart anvil-node
        docker restart hello-world
        docker restart deploy-node-1
        docker restart deploy-fluentbit-1
        docker restart deploy-redis-1
        
        sleep 60
    else
        # Log no error found
        echo "Error not found. No restart needed at $(date)"
    fi
}

# Infinite loop to keep the script running
while true; do
    check_and_restart
    sleep 30
done