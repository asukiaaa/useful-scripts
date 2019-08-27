#!bin/sh

if [[ $1 = "" ]]; then
  echo "Please execute with authtoken of ngrok.
$0 your_token"
  exit 1
fi

AUTHTOKEN=$1

# RASPI_DIR=/
RASPI_DIR=/media/${USER}/rootfs/

cd /tmp
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-arm.zip
sudo mv ngrok ${RASPI_DIR}usr/local/bin/

START_COMMAND='/usr/local/bin/ngrok start --all --config=/home/pi/.ngrok2/ngrok.yml --log=stdout >> /dev/null &'
sudo sed -i "/^exit 0/i${START_COMMAND}" ${RASPI_DIR}etc/rc.local

mkdir -p ${RASPI_DIR}home/pi/.ngrok2

echo "authtoken: ${AUTHTOKEN}
region: ap
tunnels:
  ssh:
    proto: tcp
    addr: 22
" >> ${RASPI_DIR}home/pi/.ngrok2/ngrok.yml
