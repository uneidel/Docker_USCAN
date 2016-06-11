#!/usr/bin/with-contenv bash
set -e
set -x
cupsctl --remote-admin &&  cupsctl --remote-any
if [ $(grep -ci $CUPS_USER_ADMIN /etc/shadow) -eq 0 ]; then
    useradd $CUPS_USER_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_USER_PASSWORD)
fi
