#! /bin/bash
echo Killing Aria2.
killall aria2c
echo Updating trackers.
list=`wget -qO- https://trackerslist.com/all.txt|awk NF|sed ":a;N;s/\n/,/g;ta"`
if [ -z "`grep "bt-tracker" /home/pi/.config/aria2/aria2.conf`" ]; then
    sed -i '$a bt-tracker='${list} /home/pi/.config/aria2/aria2.conf
else
    sed -i "s@bt-tracker=.*@bt-tracker=$list@g" /home/pi/.config/aria2/aria2.conf
fi
echo Starting Aria2.
aria2c --conf-path=/home/pi/.config/aria2/aria2.conf -D
