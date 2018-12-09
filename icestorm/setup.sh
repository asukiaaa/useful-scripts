#!/bin/bash
# Reference: http://www.clifford.at/icestorm/

sudo apt-get install -y \
     git build-essential clang bison flex libreadline-dev \
     gawk tcl-dev libffi-dev git mercurial graphviz   \
     xdot pkg-config python python3 libftdi-dev \
     qt5-default python3-dev libboost-dev

RULE_FILE=/etc/udev/rules.d/53-lattice-ftdi.rules
if [ ! -f $RULE_FILE ]; then
  echo 'ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0660", GROUP="plugdev", TAG+="uaccess"' | sudo tee $RULE_FILE
  sudo udevadm control --reload-rules && udevadm trigger
fi

# sudo sed -i -e 's/CONF_SWAPSIZE=100$/CONF_SWAPSIZE=500/g' /etc/dphys-swapfile
# sudo /etc/init.d/dphys-swapfile restart

mkdir -p ~/gitprojects
cd ~/gitprojects

git clone https://github.com/cliffordwolf/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install

cd ../

git clone https://github.com/cseed/arachne-pnr.git arachne-pnr
cd arachne-pnr
make -j$(nproc)
sudo make install

cd ../

git clone https://github.com/YosysHQ/nextpnr nextpnr
cd nextpnr
cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local .
make -j$(nproc)
sudo make install

cd ../

git clone https://github.com/cliffordwolf/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install

# sudo sed -i -e 's/CONF_SWAPSIZE=500$/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
# sudo /etc/init.d/dphys-swapfile restart
