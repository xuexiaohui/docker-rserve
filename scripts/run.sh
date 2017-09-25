#!/bin/bash

# Initialize first run
if [[ -e /home/ruser/.firstrun ]]; then
    /home/ruser/scripts/first_run.sh
fi


/usr/local/lib/R/site-library/Rserve/libs/Rserve --RS-port 6311  --RS-enable-remote --no-save --RS-conf rserve.conf 
while true; do
  sleep 1
done

