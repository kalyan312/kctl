#!/bin/bash

echo "[TASK]  Generating ssh key";
ssh-keygen -b 2048 -t rsa -f /tmp/sshkey -q -N ""

