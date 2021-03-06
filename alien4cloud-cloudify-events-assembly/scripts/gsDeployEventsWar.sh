#!/bin/sh

if [ -z "${JAVA_HOME}" ]; then
    # echo "The JAVA_HOME environment variable is not set. Using the java that is set in system path."
  JAVACMD=java
else
    # echo JAVA_HOME environment variable is set to ${JAVA_HOME} in "<GigaSpaces Root>\bin\setenv.sh"
  JAVACMD="${JAVA_HOME}/bin/java"
fi
export JAVACMD

if [ -z "${LUS_IP_ADDRESS}" ]; then
    # echo "The LUS_IP_ADDRESS environment variable is not set. Using localhost:4174."
  LUS_IP_ADDRESS="localhost:4174"
fi
echo "Deploying custom events on locator(s) $LUS_IP_ADDRESS"

cd `dirname $0`
HOME=$PWD/..
cd $OLDPWD

CLASSPATH="$HOME"/lib/*
ARGS="-name events -locators $LUS_IP_ADDRESS -pu $HOME/deploy/alien4cloud-cloudify-events.war"

if [ "$#" -gt 0 ]; then
  ARGS="$ARGS -username $1"
fi

if [ "$#" -gt 1 ]; then
  ARGS="$ARGS -password $2"
fi

$JAVACMD -cp "$CLASSPATH" alien4cloud.paas.cloudify2.events.GigaSpacesPUDeployer $ARGS
