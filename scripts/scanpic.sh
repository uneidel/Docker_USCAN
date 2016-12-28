#!/bin/bash
resolution=300
format=jpg
scantype=adf
SCANTARGET=/srv/scanner/
if [ ! -z "$1" ]; then
  resolution=$1
fi

if [ ! -z "$2" ]; then
  format=$2
fi

if [ ! -z "$3" ]; then
  adf=$3
fi


today=`date +%Y-%m-%d.%H_%M_%S`
OUTPUTFILE=$SCANTARGET$today.jpg
echo $OUTPUTFILE
if [ "$scantype" == "adf" ];then
  scanimage --resolution $resolution --source="Automatic Document Feeder" -x 215 -y 280 --format=tiff | convert tiff:- $OUTPUTFILE
else
  scanimage --resolution $resolution -x 215 -y 280 --format=tiff | convert pdf:- $OUTPUTFILE
fi
