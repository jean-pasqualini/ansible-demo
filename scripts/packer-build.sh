#!/usr/bin/env bash
PACKER_UPGRADE=${PACKER_UPGRADE:=0}
PACKER_FILE=${PACKER_FILE}

export ANSIBLE_GROUPS
packer build -var "ssh_private_key_file=$HOME/.ssh/id_rsa" "./packer/$PACKER_FILE.json"
