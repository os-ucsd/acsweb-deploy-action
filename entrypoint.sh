#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "Starting a UCSD ACSWeb Deploy to $INPUT_USERNAME acsweb.ucsd.edu... "

sshpass -p $INPUT_PASSWORD rsync -vzr --delete --exclude '.*'  -e 'ssh -o StrictHostKeyChecking=no' $INPUT_LOCAL_DIR $INPUT_USERNAME@acsweb.ucsd.edu:~/public_html/$INPUT_REMOTE_DIR

echo "UCSD ACSWeb Deploy complete! 🚀"
exit 0
