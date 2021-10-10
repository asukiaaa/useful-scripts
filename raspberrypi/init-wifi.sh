#!/bin/sh

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
" | tee --append /media/$USER/boot/wpa_supplicant.conf > /dev/null
