#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "starting..."

ls -lah

pwd

echo $INPUT_USERNAME $INPUT_REMOTE_DIR $INPUT_LOCAL_DIR


sshpass -p $INPUT_PASSWORD scp -o StrictHostKeyChecking=no -r $INPUT_USERNAME@acsweb.ucsd.edu:~/public_html/$INPUT_REMOTE_DIR $INPUT_LOCAL_DIR

echo "UCSD Personal Site Deploy complete"
exit 0
