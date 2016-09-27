#!/bin/bash
cd `dirname $0`
BIN_DIR=`pwd`

cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf
find $DEPLOY_DIR/lib |grep logback |xargs rm -rf

APPLICATION_STARTER=`sed '/application.starter/!d;s/.*=//' conf/application.properties | tr -d '\r'`
SERVER_NAME=`sed '/application.name/!d;s/.*=//' conf/application.properties | tr -d '\r'`
LOGS_FILE=`sed '/application.log4j.file/!d;s/.*=//' conf/application.properties | tr -d '\r'`
PROFILE=`sed '/application.profile/!d;s/.*=//' conf/application.properties | tr -d '\r'`

if [ -z "$SERVER_NAME" ]; then
    SERVER_NAME=`hostname`
fi

PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -n "$PIDS" ]; then
    echo "启动失败: 服务 $SERVER_NAME 正在运行!"
    echo "进程号: $PIDS"
    exit 1
fi

LOGS_DIR=""
if [ -n "$LOGS_FILE" ]; then
    LOGS_DIR=`dirname $LOGS_FILE`
else
    LOGS_DIR=$DEPLOY_DIR/logs
fi
if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi
STDOUT_FILE=$LOGS_DIR/stdout.log

LIB_DIR=$DEPLOY_DIR/lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`

echo -e "$SERVER_NAME 正在启动 ..."

java -classpath $CONF_DIR:$LIB_JARS $APPLICATION_STARTER $PROFILE > $STDOUT_FILE 2>&1 &
echo "启动完成!"
PIDS=`ps -ef | grep java | grep "$DEPLOY_DIR" | awk '{print $2}'`
echo "进程号:$PIDS"
echo "日志输出:$STDOUT_FILE"