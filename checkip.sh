#!/bin/bash
#small script that checks if ip changes, and alert me via mail if so
#very useful for instable vpn providers...
CHECK_ADDR="https://ipv4.wtfismyip.com/text"
CMD=`wget -q --no-check-certificate -O - $CHECK_ADDR`
STRING=`echo $CMD`
if [ $STRING == "XXX.XXX.XXX.XXX" ] #CHANGEME: your ip that should cause a warning
then
    echo "your ip changed, please check your settings." | mailx -v -A nblog -s "ip changed" email@sms.at
    echo "your ip changed, please check your settings." | mailx -v -A nblog -s "ip just changed" email@gmail.com 
    echo `date` "your ip changed back out of your vpn" >> ipchanged.log
    #stop and kill anything active as a security precaution
    sudo service someservice stop
    killall someprogram
else
    #echo "were good."
    #echo `date` "your ip stayed the same" >> ipnochange.log
fi
exit 0
