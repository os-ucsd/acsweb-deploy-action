#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "starting..."

ls -lah

pwd

sshpass -p $INPUT_PASSWORD scp -r $INPUT_USERNAME@acsweb.ucsd.edu:/public_html/$INPUT_REMOTE_DIR $INPUT_LOCAL_DIR

echo "UCSD Personal Site Deploy complete"
exit 0
