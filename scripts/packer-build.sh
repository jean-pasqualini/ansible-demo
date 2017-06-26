#!/usr/bin/env bash
PACKER_UPGRADE=${PACKER_UPGRADE:=0}
packer build -var "ssh_private_key_file=$HOME/.ssh/id_rsa" ./packer/demo.json