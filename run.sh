#!/bin/bash
docker run --net=host --privileged -p 5353:5353 -e CUPS_USER_ADMIN=cups -e CUPS_USER_PASSWORD=cups \
     -p 3702:3702 \
    -p 631:631 -it -v /home/batzi:/srv/scanner -v /dev/bus/usb:/dev/bus/usb  \
         -v /var/run/dbus:/var/run/dbus uneidel/printscan:v02 /bin/bash
#docker run --publish-all --privileged -e CUPS_USER_ADMIN=cups -e CUPS_USER_PASSWORD=cups \
# -it -v /home/batzi:/srv/scanner -v /dev/bus/usb:/dev/bus/usb  \
#         -v /var/run/dbus:/var/run/dbus uneidel/printscan:v02 /bin/bash
