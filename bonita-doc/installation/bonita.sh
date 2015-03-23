#!/bin/bash
 
### BEGIN INIT INFO
# Provides:          update-dns
# Required-Start:    $network $syslog
# Required-Stop:     $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage BonitaBPM
# Description: start, stop, restart and get status of BonitaSoft
### END INIT INFO

. /lib/lsb/init-functions

BONITA_BASE=/home/bonita/bonita
STARTUP=$BONITA_BASE/bin/startup.sh
SHUTDOWN=$BONITA_BASE/bin/shutdown.sh
PID=""
#test -x $STARTUP || exit 0

case "$1" in

    start)
        PID=`ps -eF | grep bonita | grep java | awk '{print $2}'`
        if [[ "x" != "x$PID" ]];then
    	    echo "Server is already running with PID "$PID"."
	else
	    log_begin_msg "Starting Bonita ..."
	    echo ""
            su -l bonita -c "$STARTUP"
        fi
        log_end_msg 0
    ;;

    stop)
        log_begin_msg "Stopping Bonita ..."
        echo ""
        $SHUTDOWN
        log_end_msg 0
    ;;

    status)
	PID=`ps -eF | grep bonita | grep java | awk '{print $2}'`
        if [[ "x" != "x$PID" ]];then
            echo "Server is running with PID "$PID"."
        else
            echo "Server is not running"
        fi
    ;;

    *)
        log_failure_msg "Usage: $0 {start|stop|status}"
        exit 0
esac

exit 0


