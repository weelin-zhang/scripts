#!/bin/sh

cd /opt/yrd_soft/redis/bin/

cat > nodeslist <<EOF
10.134.80.36
10.134.80.56
10.134.80.72
10.134.80.92
EOF
grep -v "^$" nodeslist > tmp
mv tmp nodeslist
PASSWORD=xxxxxxxxxxxxx

M_PORT=6379

S_PORT=7379

while  read line

do

su redis -s /bin/sh -c "./redis-cli -h $line -p ${M_PORT} config set masterauth ${PASSWORD}"

su redis -s /bin/sh -c "./redis-cli -h $line -p ${M_PORT} config set requirepass ${PASSWORD}"

su redis -s /bin/sh -c "./redis-cli -h $line -p ${M_PORT} -a ${PASSWORD} config rewrite"

su redis -s /bin/sh -c "./redis-cli -h $line -p ${S_PORT} config set masterauth ${PASSWORD}"

su redis -s /bin/sh -c "./redis-cli -h $line -p ${S_PORT} config set requirepass ${PASSWORD}"

su redis -s /bin/sh -c "./redis-cli -h $line -p ${S_PORT} -a ${PASSWORD} config rewrite"

done<nodeslist