#!/usr/bin/env bash

echo Starting mysql service...

service mysql start
#/etc/init.d/mysql start

echo Setup Syncope Database through initializeSyncopeDB.sql script

cd /app/                                                                                                                                         
mysql -uroot -proot < /app/initializeSyncopeDB.sql                                                                                               
echo START TOMCAT                                                                                                                                                                        
echo "Wait for container startup... about 60 seconds remaining..."

/apache-tomcat-8.0.23/bin/startup.sh

for i in {0..60..1}
  do
     echo "Wait for container startup... $((60 - $i)) seconds remaining"
     sleep 1
 done

tail -f /apache-tomcat-8.0.23/logs/catalina.out

