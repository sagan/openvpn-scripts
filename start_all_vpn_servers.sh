#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

killall openvpn
cd $SCRIPTPATH
for F in `ls *.server_start.sh`
do
	./F &
done

