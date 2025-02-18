#!/bin/sh

DIR_HERE=$(dirname $(realpath $0))

if [ "$1" = "" ]; then
  echo "Please execute with ssh public key
$0 public_key_file

Example:
$0 ~/.ssh/id_rsa.pub"
  exit 1
fi

sudo -v

HOME_DIR=`$DIR_HERE/get-path-home-dir.sh`
HOME_DISC=`realpath $HOME_DIR/../../`

touch `$DIR_HERE/get-path-bootfs.sh`/ssh

# ref: https://asukiaaa.blogspot.com/2021/09/raspberrypi-ssh-login-with-using-public-key.html

mkdir -p $HOME_DIR/.ssh
touch $HOME_DIR/.ssh/authorized_keys
chmod 600 $HOME_DIR/.ssh/authorized_keys
cat $1 >> $HOME_DIR/.ssh/authorized_keys

sudo sed -i -e "s/#PasswordAuthentication yes/PasswordAuthentication no/g" $HOME_DISC/etc/ssh/sshd_config

sync
