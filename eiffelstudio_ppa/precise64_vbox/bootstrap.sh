#!/usr/bin/env bash

apt-get update
apt-get install -y curl dos2unix
apt-get install -y subversion git

if [ -d /vagrant/bootstrap ];
then
	ls -1 /vagrant/bootstrap/*.sh | while read script
	do
		echo "Execute bootstrap $script"
		dos2unix $script
		bash $script
	done
fi
echo "Bootstrap completed"
