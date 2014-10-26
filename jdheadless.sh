#!/bin/sh
#
# Startup script for jdownloader2
# found this one online, modified a bit for lower memory usage
# my version also dynamically searches for the correct java binary and the correct JDownloader.jar
PIDFILE=~/jd2/tmp/jdheadless.pid
start() {
	sleep 1
		nohup $(which java) -Djava.awt.headless=true -server -Xms64m -Xmx64m -XX:MaxPermSize=512m -jar $(locate JDownloader.jar |head -1) &
		echo $! > $PIDFILE
}
stop() {
	[ -f ${PIDFILE} ] && kill `cat ${PIDFILE}`
		rm -f $PIDFILE
}
case "$1" in
start)
start
;;
stop)
stop
;;
restart)
stop
sleep 1
start
;;
*)
echo "Usage: $0 (start|stop|restart)"
exit 1
;;
esac
