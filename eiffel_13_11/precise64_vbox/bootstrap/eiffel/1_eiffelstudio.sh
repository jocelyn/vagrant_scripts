#!/usr/bin/env bash

echo Setup EiffelStudio dev environment ...
mkdir -p ~/projects

echo Get source code
svn checkout --non-interactive --trust-server-cert https://svn.eiffel.com/eiffelstudio/trunk/Src ~/projects/eiffelstudio

echo export EIFFEL_SRC=~/projects/eiffelstudio >> /home/eiffel/etc/default

. /home/eiffel/etc/default

cd ~/projects/eiffelstudio
echo Compile all Clibs ...
geant prepare

echo Compile EiffelStudio batch
mkdir -p ~/_COMP
ecb -config $EIFFEL_SRC/Eiffel/Ace/ec.ecf -target batch -finalize -c_compile -project_path ~/_COMP


