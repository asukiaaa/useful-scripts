#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
  echo "Please execute with ssid device and pass.
$0 ssid pass

Example:
$0 myWiFiId password"
  exit 1
fi

echo "
network={
    ssid=\"$1\"
    psk=\"$2\"
}" | sudo tee --append /media/$USER/rootfs/etc/wpa_supplicant/wpa_supplicant.conf > /dev/null
