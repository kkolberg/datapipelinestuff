#!/bin/bash
# My first script

ZIP_S3=$1
CONFIG_S3=$2


if test -f ./.venv
then
    echo "----- .venv exists, deleting -----"
    rm -rf ./.venv
else
    echo "----- .venv DOES NOT exists -----"
fi

echo "----- Downloading $ZIP_S3 -----"
aws s3 cp $ZIP_S3 ./pythonScript.zip
echo "----- Download finished for $ZIP_S3 -----"

if test -f ./pythonScript.zip 
then
    echo "----- pythonScript.zip exists -----"
else
    echo "----- pythonScript.zip DOES NOT exists -----"
fi

echo "----- Unzipping -----"
unzip -qq -o pythonScript.zip
echo "----- Unzipping finished -----"
if test -f ./.venv
then
    echo "----- .venv exists, deleting -----"
    rm -rf ./.venv
else
    echo "----- .venv DOES NOT exists -----"
fi
if test -f ./run.sh
then
    echo "----- run.sh exists -----"
else
    echo "----- run.sh DOES NOT exists -----"
fi

sh ./run.sh $CONFIG_S3
