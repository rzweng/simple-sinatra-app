#!/bin/bash

REQUIRED_RSS="puppet"
SCRIPT_PATH="$(dirname "$0")"

for i in $REQUIRED_RSS
do
  if ! (command -v $i >/dev/null 2>&1)
  then
    echo "$i not installed on the system"
    exit 1
  fi
done

puppet apply --modulepath="${SCRIPT_PATH}/modules" "${SCRIPT_PATH}/manifests/deploy.pp"
