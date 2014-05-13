#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

sysctl -w net.ipv4.ip_forward=1
if ! iptables -t nat -vxnL POSTROUTING | grep '192.168\.0\.0' > /dev/null
then
	iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE
fi

openvpn --cd $SCRIPTPATH --config ##SERVER_CONF_FILE## &

