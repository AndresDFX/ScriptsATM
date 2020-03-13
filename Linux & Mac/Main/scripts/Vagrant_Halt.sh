#!/usr/bin/env bash
if [ -z "$1" ]
then
  OPTS=""
else
  # force close if any arg passed
  OPTS="-f"
fi

for i in $(vagrant global-status | grep running | awk '{print $1}'); do 
  DIR=$(vagrant global-status | grep running | awk '{print $5}')
  cd "$DIR";
  OUT=$(vagrant halt);
  echo "attempted to halt $i: $OUT"
done