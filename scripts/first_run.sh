#!/bin/bash

USER=${RSERVE_USERNAME:-rserve}
PASS=${RSERVE_PASSWORD:-$(pwgen -s -1 16)}

# Create User
echo "Creating user: \"$USER\"..."
cat > /home/ruser/passwordfile << EOF1
$USER $PASS
EOF1

echo "========================================================================"
echo "RServe User: \"$USER\""
echo "RServe Password: \"$PASS\""
echo "========================================================================"

rm -f /home/ruser/.firstrun

