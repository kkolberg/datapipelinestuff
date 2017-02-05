#!/bin/bash
# My first script

ZIP_S3=$1
CONFIG_S3=$2

echo "----- Downloading $ZIP_S3 -----"
aws s3 cp $ZIP_S3 ./pythonScript.zip
echo "----- Download finished for $ZIP_S3 -----"


echo "----- Unzipping -----"
unzip -qq -o pythonScript.zip -d ./pythonScript
echo "----- Unzipping finished -----"

sh ./pythonScript/run.sh $CONFIG_S3

rm -rf ./pythonScript
rm -rf ./pythonScript.zip
