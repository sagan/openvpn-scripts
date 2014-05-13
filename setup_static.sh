#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

echo -n "ID: "
read ID

echo "Select Server IP:"
IPS=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -vE '^192\.161\.' | grep -vE '^10\.'`
declare -a IPA
IPI=-1
for IP in $IPS
do
	IPI=$[IPI+1]
	IPA[$IPI]=$IP
	echo "$IPI: $IP"
done
echo -n "Enter Index [0-$IPI]: "
read SERVER_IP_INDEX
if [ "$SERVER_IP_INDEX" -lt 0 -o "$SERVER_IP_INDEX" -gt $IPI ]
then
	echo "invalid index"
	exit 1
fi
SERVER_IP=${IPA[$SERVER_IP_INDEX]}

echo -n "Server Port: "
read SERVER_PORT

echo -n "Subnet mask C Number: "
read SUBNETMASK_C

printf "\n\nConfirm Info:\nID: $ID\nServer IP: $SERVER_IP\nServer Port: $SERVER_PORT\nSubnet Mask C Number: $SUBNETMASK_C (192.168.$SUBNETMASK_C.0)\n"
printf "\nIs it OK ? (y/n): "
read CONFIRM
if [ "$CONFIRM" != "y" -a "$CONFIRM" != "yes" ]
then
	echo "abandon"
	exit 1
fi

WD=$HOME/openvpn
mkdir -p $WD
cd $WD

openvpn --genkey --secret ${ID}.key
cp $SCRIPTPATH/server_static.conf $ID.server.conf
cp $SCRIPTPATH/client_static.conf $ID.client.conf
cp $SCRIPTPATH/template_server_start.sh $ID.server_start.sh && chmod +x $ID.server_start.sh
cp $SCRIPTPATH/template_client_start.sh $ID.client_start.sh && chmod +x $ID.client_start.sh

sed -i "s/##SERVER_IP##/$SERVER_IP/g" $ID.server.conf
sed -i "s/##SERVER_PORT##/$SERVER_PORT/g" $ID.server.conf
sed -i "s/##SUBNETMASK_C##/$SUBNETMASK_C/g" $ID.server.conf
sed -i "s/##STATIC_KEY_FILE##/$ID.key/g" $ID.server.conf

sed -i "s/##SERVER_IP##/$SERVER_IP/g" $ID.client.conf
sed -i "s/##SERVER_PORT##/$SERVER_PORT/g" $ID.client.conf
sed -i "s/##SUBNETMASK_C##/$SUBNETMASK_C/g" $ID.client.conf
sed -i "s/##STATIC_KEY_FILE##/$ID.key/g" $ID.client.conf

sed -i "s/##SERVER_CONF_FILE##/$ID.server.conf/g" $ID.server_start.sh
sed -i "s/##CLIENT_CONF_FILE##/$ID.client.conf/g" $ID.client_start.sh


echo "OpenVPN conf files generated in $WD"
echo "done"

