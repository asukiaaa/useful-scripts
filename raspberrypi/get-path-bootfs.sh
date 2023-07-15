#!/bin/sh

PATH_BOOT=/media/$USER/boot/
PATH_BOOTFS=/media/$USER/bootfs/

if [ -d $PATH_BOOT ]; then
  echo $PATH_BOOT
elif [ -d $PATH_BOOTFS ]; then
  echo $PATH_BOOTFS
fi
