#!/bin/sh
#
# Usage: ./ps_loop.sh <sleep>
#
SLEEP=1
if [ "X$1" !=  "X" ]; then
  SLEEP=$1
fi
while [ 1 ]
do
   ps auxf
   sleep $SLEEP
done
