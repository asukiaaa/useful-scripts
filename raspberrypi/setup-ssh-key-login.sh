#!/bin/sh

if [ "$1" = "" ]; then
  echo "Please execute with ssh public key
$0 public_key_file

Example:
$0 ~/.ssh/id_rsa.pub"
  exit 1
fi

sudo -v

HOME_DISC=/media/$USER/rootfs
HOME_DIR=$HOME_DISC/home/pi
touch /media/$USER/boot/ssh

# ref: https://asukiaaa.blogspot.com/2021/09/raspberrypi-ssh-login-with-using-public-key.html

mkdir -p $HOME_DIR/.ssh
touch $HOME_DIR/.ssh/authorized_keys
chmod 600 $HOME_DIR/.ssh/authorized_keys
cat $1 >> $HOME_DIR/.ssh/authorized_keys

sudo sed -i -e "s/#PasswordAuthentication yes/PasswordAuthentication no/g" $HOME_DISC/etc/ssh/sshd_config

sync
