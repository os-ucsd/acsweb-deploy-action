#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "starting..."

ls -lah

pwd

echo 1, $INPUT_USERNAME, 2, $INPUT_REMOTE_DIR, 3, $INPUT_LOCAL_DIR


sshpass -p $INPUT_PASSWORD rsync -o StrictHostKeyChecking=no -vzr --delete --exclude '.*'  -e ssh $INPUT_LOCAL_DIR $INPUT_USERNAME@acsweb.ucsd.edu:~/public_html/$INPUT_REMOTE_DIR

echo "UCSD Personal Site Deploy complete"
exit 0
