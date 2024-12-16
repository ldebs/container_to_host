#!/bin/bash

for FILE in $(realpath $(dirname $0))/container/scripts/1*/*.sh; do . $FILE; done
FILE=$0

mkdir /tmp/run_host
HOST_CMD=/tmp/run_host/$$_cmd
HOST_STS=/tmp/run_host/$$_sts
HOST_OUT=/tmp/run_host/$$_out
HOST_ERR=/tmp/run_host/$$_err
HOST_IN=/tmp/run_host/$$_in
mkfifo $HOST_CMD $HOST_STS $HOST_OUT $HOST_ERR
touch $HOST_IN
chmod a+w $HOST_CMD

while true; do
  cmdStr=$(cat $HOST_CMD)
  cmd=$(mktemp -u)
  echo "$cmdStr" > $cmd
  chmod +x $cmd
  resCmd=0
  $cmd < $HOST_IN > $HOST_OUT 2> $HOST_ERR || resCmd=$?
  rm -f $cmd
  echo $resCmd > $HOST_STS
done &
LOOP_PID=$!

trap "rm -rf /tmp/run_host; kill -STOP $LOOP_PID" EXIT

run docker run \
  --name test \
  -v ./container:/opt/container -w /opt/container \
  -e HOST_CMD=$HOST_CMD -v $HOST_CMD:$HOST_CMD \
  -e HOST_STS=$HOST_STS -v $HOST_STS:$HOST_STS \
  -e HOST_OUT=$HOST_OUT -v $HOST_OUT:$HOST_OUT \
  -e HOST_ERR=$HOST_ERR -v $HOST_ERR:$HOST_ERR \
  -e HOST_IN=$HOST_IN -v $HOST_IN:$HOST_IN \
  --rm -ti busybox /opt/container/entrypoint.sh

log "$OC################ end run"
