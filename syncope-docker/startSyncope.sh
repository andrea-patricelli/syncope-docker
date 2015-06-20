#!/usr/bin/env bash

echo START MYSQL SERVICE

service mysql start
#/etc/init.d/mysql start

echo SETUP DATABASE

cd /app/                                                                                                                                         
echo I am in `pwd`
echo CONFIGURE SYNCOPE DATABASE

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

