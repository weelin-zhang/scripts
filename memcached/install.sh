#!/bin/sh

[ ${#} -lt 3 ] && { echo -e "\033[31mUsage: sh $0 ip port memory(m)\nexample: sh $0 1.1.1.1 11211 128\033[0m";exit 6; }

yum install libevent libevent-deve memcached -y |tail -n 20

mkdir -p /opt/yrd_logs/memcached
chown -R memcached. /opt/yrd_logs/memcached
memcached_cmd=`which memcached`
host=$1
port=$2
mem=$3
logpath=/opt/yrd_logs/memcached/memcached.log
$memcached_cmd  -d -u memcached -m ${mem}m -l ${host} -P /var/run/memcached.pid -p $port -vv >> ${logpath} 2>&1
