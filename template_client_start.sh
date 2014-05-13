#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

openvpn --cd $SCRIPTPATH --config ##CLIENT_CONF_FILE## &

