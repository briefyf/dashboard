#!/bin/bash
cd `dirname $0`
BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf

SERVER_NAME=`sed '/application.name/!d;s/.*=//' conf/application.properties | tr -d '\r'`

if [ -z "$SERVER_NAME" ]; then
    SERVER_NAME=`hostname`
fi

_PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -z "$_PIDS" ]; then
    echo "失败:服务 $SERVER_NAME 没有启动!"
    exit 1
fi

echo -e "服务 $SERVER_NAME 正在停止..."
for PID in $_PIDS ; do
    kill $PID > /dev/null 2>&1
done

COUNT=0
while [ $COUNT -lt 1 ]; do
    sleep 1
    COUNT=1
    for PID in $_PIDS ; do
        PID_EXIST=`ps -f -p $PID | grep java`
        if [ -n "$PID_EXIST" ]; then
            COUNT=0
            break
        fi
    done
done
echo "服务进程号: $_PIDS"
echo "服务已停止!"
