#!/usr/bin/env bash

echo "Setup eiffel environment"

echo "Using ppa:eiffelstudio-team/ppa"
apt-get install -y python-software-properties

add-apt-repository -y ppa:eiffelstudio-team/ppa 
apt-get update 
apt-get install -y eiffelstudio

echo "Create new user [eiffel]"
sudo /usr/sbin/useradd -p `openssl passwd -1 eiffel` eiffel --create-home --shell /bin/bash

if [ -d /vagrant/bootstrap/eiffel ];
then
	ls -1 /vagrant/bootstrap/eiffel/*.sh | while read script
	do
		echo "Execute $script as user [eiffel]"
		dos2unix $script
		/usr/bin/sudo -H -u eiffel -s "$script"
	done
fi

echo "Eiffel environment: completed"
