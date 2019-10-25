#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "starting..."

sshpass -p $PASSWORD scp -r $USERNAME@acsweb.ucsd.edu:/public_html/$REMOTE_DIR $LOCAL_DIR

echo "UCSD Personal Site Deploy complete"
exit 0
