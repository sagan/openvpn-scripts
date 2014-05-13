#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

openvpn --cd $SCRIPTPATH --config ##SERVER_CONF_FILE## &

