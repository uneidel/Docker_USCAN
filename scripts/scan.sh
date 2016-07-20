#!/bin/bash
#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) BASEDIR=/tmp/ WKDIR=$BASEDIR"$RANDOM.$RANDOM"

if [ -d $WKDIR ]; then
echo "Folder Exists... Exiting"
exit 0
fi


mkdir $WKDIR
scanimage --source="Automatic Document Feeder" --adf-mode Duplex --resolution 300 -x 215 -y 280 --format=pnm --batch=$WKDIR/dp%d.pnm echo "processing..."
if [ "$1" == "merge" ]
then
 echo "merging...."
 nohup $DIR/merge.sh $WKDIR $2 &
else
 nohup $DIR/process.sh $WKDIR $2 &
fi
