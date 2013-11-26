#!/usr/bin/env bash

echo "Setup eiffel environment"

apt-get install -y libgtk2.0-dev libxtst-dev

echo "Create new user [eiffel]"
#sudo useradd eiffel --create-home --shell /bin/bash
#sudo $( echo "eiffel:eiffel" | chpasswd )
sudo /usr/sbin/useradd -p `openssl passwd -1 eiffel` eiffel --create-home --shell /bin/bash

if [ -d /vagrant/ftp/eiffel ];
then
	echo "/vagrant/ftp/eiffel already exists."
else
	mkdir /vagrant/ftp/eiffel
fi

echo "Set Eiffel the owner of ftp/eiffel"
chown -R eiffel:eiffel /vagrant/ftp/eiffel

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
