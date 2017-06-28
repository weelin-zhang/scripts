#!/bin/sh

logfilepath=/opt/logs/mongodb/mongod.log
pidfilepath=/var/run/mongodb/mongod.pid
logpath=/opt/logs/mongodb/
pidpath=/var/run/mongodb/
datapath=/opt/data/mongodb/

echo "[mongodb-2.6.12]" > /etc/yum.repos.d/mongodb-2_6_12.repo
echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-2_6_12.repo
echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64" >> /etc/yum.repos.d/mongodb-2_6_12.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb-2_6_12.repo

yum -q -y install mongodb-org

mongo -h |head

chattr -i /etc/passwd /etc/shadow /etc/group /etc/gshadow
useradd -M -s /sbin/nologin mongod >/dev/null 2>&1
chattr +i /etc/passwd /etc/shadow /etc/group /etc/gshadow

mkdir -p $logpath $pidpath $datapath
chown -R mongod.mongod $logpath $pidpath $datapath

sed -i '/logpath/d' /etc/mongod.conf
sed -i '/dbpath/d' /etc/mongod.conf
sed -i '/pidfilepath/d' /etc/mongod.conf
sed -i '/logappend=/i logpath='${logfilepath}'' /etc/mongod.conf
sed -i '/logappend=/i dbpath='${datapath}'' /etc/mongod.conf
sed -i '/logappend=/i pidfilepath='${pdifilepath}'' /etc/mongod.conf
/etc/init.d/mongod restart
