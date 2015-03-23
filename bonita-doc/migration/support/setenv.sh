#!/bin/sh

# Sets some variables
BONITA_HOME="-Dbonita.home=${CATALINA_HOME}/bonita"
DB_OPTS="-Dsysprop.bonita.db.vendor=postgres"
BTM_OPTS="-Dbtm.root=${CATALINA_HOME} -Dbitronix.tm.configuration=${CATALINA_HOME}/conf/bitronix-config.properties"
SECURITY_OPTS="-Djava.security.auth.login.config=${CATALINA_HOME}/conf/jaas.conf"

# setting the same value for Xms and Xmx should prevent garbage collecting and decrease performance issues due to
# this
CATALINA_OPTS="${CATALINA_OPTS} ${BONITA_HOME} ${DB_OPTS} ${BTM_OPTS} ${SECURITY_OPTS}  -Dfile.encoding=UTF-8 -Xshare:auto -Xms1024m -Xmx1024m -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError"



export CATALINA_OPTS

CATALINA_PID=${CATALINA_BASE}/catalina.pid
export CATALINA_PID
