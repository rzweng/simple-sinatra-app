#!/bin/bash
if [ $UID -ne 0 ]
then
  echo 'Script must be run as root!'
  exit 1
fi

REQUIRED_BINARIES="puppet"
SCRIPT_PATH="$(dirname "$0")"

#check for required binaries on system
for i in $REQUIRED_BINARIES
do
  if ! (command -v $i >/dev/null 2>&1)
  then
    echo "$i required but not available on this system"
    exit 2
  fi
done

puppet apply --modulepath="${SCRIPT_PATH}/modules" "${SCRIPT_PATH}/manifests/site.pp"
