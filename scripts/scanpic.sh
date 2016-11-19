#!/bin/bash
resolution=300
format=jpg
SCANTARGET=/srv/scanner/
if [ ! -z "$1" ]; then
  resolution=$1
fi

if [ ! -z "$2" ]; then
  format=$2
fi
today=`date +%Y-%m-%d.%H_%M_%S`
OUTPUTFILE=$SCANTARGET$today.jpg
echo $OUTPUTFILE
if [ "$format" == "jpg" ];then
  scanimage --resolution $resolution -x 215 -y 280 --format=tiff | convert tiff:- $OUTPUTFILE
else
  scanimage --resolution $resolution -x 215 -y 280 --format=tiff | convert pdf:- $OUTPUTFILE
fi
