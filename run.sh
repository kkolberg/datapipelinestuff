#!/bin/bash
CONFIG_S3=$1
# wget https://bootstrap.pypa.io/get-pip.py
# sudo pypy get-pip.py


echo "----- starting virtualenv -----"
sudo -H pip install virtualenv
virtualenv -p /usr/bin/pypy .venv
echo "----- finished virtualenv -----"

echo "----- activating virtualenv -----"
. .venv/bin/activate
pip install -r requirements.txt
echo "----- activated virtualenv and installed pip -----"

echo "----- starting app.py with config $CONFIG_S3 -----"
pypy app.py $CONFIG_S3
echo "----- app.py finished -----"

