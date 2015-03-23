#!/bin/bash
# Bundle configuration files into tomcat

SUPPORT=/home/bonita/support
BONITA_BASE=/home/bonita/bonita

cp -v $SUPPORT/bonita.xml $BONITA_BASE/conf/Catalina/localhost/bonita.xml
cp -v $SUPPORT/bitronix-resources.properties $BONITA_BASE/conf/bitronix-resources.properties
cp -v $SUPPORT/setenv.sh $BONITA_BASE/bin/setenv.sh
cp -v $SUPPORT/bonita-server.properties $BONITA_BASE/bonita/server/platform/tenant-template/conf/bonita-server.properties
cp -v $SUPPORT/bonita-platform.properties $BONITA_BASE/bonita/server/platform/conf/bonita-platform.properties
cp -v $SUPPORT/platform-tenant-config.properties $BONITA_BASE/bonita/client/platform/conf/platform-tenant-config.properties
