#!/bin/bash

set -e

# extract a control node ip from the inventory file
CONTROL_NODE_IP=$(awk '/\[control_plane\]/{flag=1;next}/\[/{flag=0}flag && NF{print $1; exit}' ansible/inventory.ini)

# connect to the control node via ssh
ssh root@"$CONTROL_NODE_IP"