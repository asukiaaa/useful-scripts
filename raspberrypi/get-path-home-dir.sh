#!/bin/sh

PATH_BOOT=/media/$USER/rootfs/
PI_USER=`ls $PATH_BOOT/home -1 | head -1`
echo $PATH_BOOT/home/$PI_USER
