#!/bin/sh

host=`ifconfig bond0|awk -F "[ ]+" NR==2'{print $3}'`
port=9201
node={{NODENAME}}
case $1 in

start)

    [ -f /home/elk/${node}.pid ] && { echo "${0%.*} is running...";exit 0; } || echo starting...
    su - elk -s /bin/sh -c "/opt/yrd_soft/${node}/bin/elasticsearch -d -p ${node}.pid"
    while [ 1 ]
    do 
        sleep 10
        curl ${host}:${port} 2>/dev/null && break
    done
;;

stop)
   [ ! -f /home/elk/${node}.pid ] && { echo "${0%.*} is stopped...";exit 0; }
   pid=`cat /home/elk/${node}.pid`
   kill -9 $pid && echo "stopped"
   rm -f /home/elk/${node}.pid
;;

*)
echo "Usage: sh  $0   {start|stop}"
;;
esac
