#!/usr/bin/env bash

if [ -f /vagrant/ftp/eiffel/linux-x86-64.tar.bz2 ];
then
	echo "Eiffel archive already exists."
else
	curl ftp://beta:beta57@ftp.eiffel.com/13.11/Eiffel_13.11_gpl_93345-linux-x86-64.tar.bz2 -o /vagrant/ftp/eiffel/linux-x86-64.tar.bz2
fi

mkdir /home/eiffel/etc
mkdir /home/eiffel/Eiffel
mkdir /home/eiffel/projects
mkdir -p /home/eiffel/spec/linux-x86-64/13.11/93345

if [ -f /home/eiffel/spec/linux-x86-64/13.11/93345/Eiffel_13.11 ];
then
	echo "Eiffel 13.11 (rev#93345) is already installed"
else
	tar xjvf /vagrant/ftp/eiffel/linux-x86-64.tar.bz2 -C /home/eiffel/spec/linux-x86-64/13.11/93345
	ln -s  /home/eiffel/spec/linux-x86-64/13.11/93345/Eiffel_13.11 /home/eiffel/Eiffel/13.11
	ln -s  /home/eiffel/Eiffel/13.11 /home/eiffel/Eiffel/default
fi

if [ -f /home/eiffel/etc/default ];
then
	echo "Etc file exists"
else
	echo export ISE_EIFFEL=/home/eiffel/Eiffel/default > /home/eiffel/etc/default
	echo export ISE_PLATFORM=linux-x86-64 >> /home/eiffel/etc/default
	echo export ISE_LIBRARY=\$ISE_EIFFEL >> /home/eiffel/etc/default
	echo export PATH=\$PATH:\$ISE_EIFFEL/studio/spec/\$ISE_PLATFORM/bin >> /home/eiffel/etc/default
	echo export PATH=\$PATH:\$ISE_EIFFEL/tools/spec/\$ISE_PLATFORM/bin >> /home/eiffel/etc/default
	echo export PATH=\$PATH:\$ISE_EIFFEL/library/gobo/spec/\$ISE_PLATFORM/bin >> /home/eiffel/etc/default
fi

. /home/eiffel/etc/default

