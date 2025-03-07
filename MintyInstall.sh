#!/bin/bash

cd ~
#sudo apt-get update ### we need no update
sudo apt-get install libpng12-dev -y
sudo apt-get install python-gpiozero -y
sudo apt-get install python-pkg-resources python3-pkg-resources -y
sudo apt-get install -y i2c-tools -y
sudo apt-get install build-essential python-dev python-smbus python-pip -y
sudo pip install adafruit-ads1x15
cd ~
sudo chmod 755 /home/pi/Mintybatterymonitor/Pngview/pngview
sudo chmod 755 /home/pi/Mintybatterymonitor/MintyStart.sh
sudo sed -i '/\"exit 0\"/!s/exit 0/\/home\/pi\/Mintybatterymonitor\/MintyStart.sh \&\nexit 0/g' /etc/rc.local

config_txt=/boot/config.txt
echo "Enabling i2c..."
if ! grep '^dtparam=i2c2_iknowwhatimdoing' $config_txt; then
  echo 'dtparam=i2c2_iknowwhatimdoing' >> $config_txt
  ## no errors in dmesg by decreasing baudrate
  echo 'dtparam=i2c_baudrate=10000' >> $config_txt

else
  echo "i2c already enabled."
fi

etc_modules=/etc/modules
echo "Adding entries to $etc_modules..."
if ! grep '^i2c-dev' $etc_modules; then
  #echo 'i2c-bcm2708' >> $etc_modules ###### no more needed in kernel 4.14
  echo 'i2c-dev' >> $etc_modules
else
  echo "$etc_modules already set up."
fi
