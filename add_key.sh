#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Adds a public key."
  echo "Requires admin access."
  echo
  echo "Usage: $0 <user>@<qnap-address> <ssh-public-key-path>"
  echo " e.g.: $0 admin@my-qnap.local ~/.ssh/id_rsa.pub"
  exit 1
fi

public_key=$(cat "$2")

embedded_script="cd /share &&
echo \"$public_key\" >> git/.ssh/authorized_keys"

output=$(ssh "$1" -v -t "/bin/sh" "-c" "'$embedded_script'" 2>&1)
echo $output
