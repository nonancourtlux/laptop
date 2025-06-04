#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.


sleep 60
sudo rm /var/run/crond.reboot 
sudo service cron restart
sleep 60

echo /usr/sbin/reboot | at  now + 5 minutes /usr/sbin/reboot 
rm -f $0



exit 0


