#!/bin/bash
docker run --privileged -p 9100:9100 -p 5353:5353 -e CUPS_USER_ADMIN=cups -e CUPS_USER_PASSWORD=cups -p 631:631 -it -v /home/batzi:/srv/scanner -v /dev/bus/usb:/dev/bus/usb -v /var/run/dbus:/var/run/dbus uneidel/printscan:v02 /bin/bash
