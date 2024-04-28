This is a script to restart your Ritual Node automatically.

Step 1:
Fetch your Docker Container ID and copy the ID for ritualnetwork/infernet-node
```
docker ps
```

Step 2:
Run this to get the full ID
```
ls /var/lib/docker/containers/ | grep <your Container ID>
```

Step 3:
Replace the full ID in line 4 of restart.sh
```
CONTAINER_ID="replace-with-your-ID"
```

Step 4:
Create a new screen to run your script
```
# Create new screen
screen -S restart

# change directory 
cd restart-script

# Run script
./restart.sh

# Detach
ctrl + A + D
```
