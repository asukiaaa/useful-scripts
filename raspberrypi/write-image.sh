#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
  echo "Please execute with target device and image.
$0 target_device image

Example:
$0 /dev/mmcblk0 ./raspbianImages/2019-07-10-raspbian-buster.img"
  exit 1
fi

dd bs=4M of=$1 if=$2 conv=fsync
