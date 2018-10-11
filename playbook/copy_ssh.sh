#!/bin/bash

# check input
if [ "$#" -lt 2 ]; then
	echo "Usage: ./copy_ssh.sh <remote_username> <remote_ip>..."
	exit 1
fi

# generate ssh key
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
	echo "Generating private key"
	ssh-keygen -t rsa -f "$HOME/.ssh/id_rsa"
else
	echo "Private key exists, skipping..."
fi

# copy ssh
argc=$#
argv=($@)
for (( i=1; i<argc; i++ )); do
	ssh-copy-id -i "$HOME/.ssh/id_rsa" "${argv[0]}@${argv[$i]}" -f
done



