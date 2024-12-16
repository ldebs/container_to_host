#!/bin/sh

SCRIPT_DIR=$(realpath $(dirname $0))/scripts

for FILE in $SCRIPT_DIR/1*/*.sh $SCRIPT_DIR/2*/*.sh; do . $FILE; done
FILE=$0

handle_log
export NOW=$(date +"%Y%m%d_%H%M%S")
log "$CC################################## $NOW $0$NC"

for FILE in $SCRIPT_DIR/test/*.sh
do
  log "$SC################ begin $FILE$NC"
  . "$FILE"
  log "$SC################ end $FILE$NC"
done

log "$OC################################## end $FILE$NC"
