#!/bin/bash

SCREEN=xray
XRAY=/home/username/xray

if screen -list | grep -q $SCREEN; then
    echo "Error: A screen session named $SCREEN already exists."
    exit 1
fi

screen -dmS $SCREEN bash -c "$XRAY/xray -c $XRAY/VLESS-XHTTP-TLS.json; exec bash"

exit 0