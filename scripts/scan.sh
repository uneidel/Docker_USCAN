#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASEDIR=/tmp/
WKDIR=$BASEDIR"$RANDOM.$RANDOM"

if [ -d $WKDIR ]; then
echo "Folder Exists... Exiting"
exit 0
fi


mkdir $WKDIR
scanimage --resolution 300 -x 215 -y 280 --format=pnm --batch=$WKDIR/document-p00%d.pnm
echo "processing..."
if [ "$1" == "merge" ]
then
 echo "merging...."
 nohup $DIR/merge.sh $WKDIR &
else
 nohup $DIR/process.sh $WKDIR &
fi
