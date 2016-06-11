#!/bin/sh
# Write pid File
PID=$$
echo $PID > /tmp/boxhandler.pid

gpm -m /dev/input/mice -t imps2
unset TERM
script -qc "mev -E" /dev/null </dev/null | grep --line-buffered -v "mouse-movement" | while read LINE
do
        EVENT=$(echo "$LINE" | cut -d' ' -f1 | cut -d'(' -f2)
	echo $EVENT
        if [ "$EVENT" = "down-mouse-321" ] || [ "$EVENT" = "down-mouse-31" ]
        then
		nohup /srv/scripts/scan.sh
        elif [ "$EVENT" = "mouse-1" ]
        then
		nohup /srv/scripts/scan.sh merge
        elif [ "$EVENT" = "mouse-2" ]
        then
	 curl http://192.168.12.1:9000/status.html?p0=play
        elif [ "$EVENT" = "down-mouse-21" ]
        then
	   curl http://192.168.12.1:9000/status.html?p0=stop
	fi

done
