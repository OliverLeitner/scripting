#!/bin/sh
#
# Startup script for jdownloader2
#
# Stop myself if running
JAVA=~/jd2/jre/bin/java
JD=~/jd2/JDownloader.jar
PIDFILE=~/jd2/tmp/jdheadless.pid
start() {
	sleep 1
		nohup $JAVA -Djava.awt.headless=true -server -Xms64m -Xmx64m -XX:MaxPermSize=512m -jar $JD &
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
