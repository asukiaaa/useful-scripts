#!/bin/sh

DIR_HERE=$(dirname $(realpath $0))

if [ "$1" = "" ] || [ "$2" = "" ]; then
  echo "Please execute with ssid device and pass.
$0 ssid pass

Example:
$0 myWiFiId password"
  exit 1
fi

echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
country=JP
update_config=1

network={
    ssid=\"$1\"
    psk=\"$2\"
}
" | tee --append `$DIR_HERE/get-path-bootfs.sh`/wpa_supplicant.conf > /dev/null

sync
