#!/usr/bin/env bash

echo Starting postgresql service...

service postgresql start

echo Setup Syncope Database through script

SYNCOPE_USER="syncope" SYNCOPE_PASS="syncope" sh /usr/share/apache-syncope/dbinit-postgresql.sh

service tomcat7 start

for i in {0..60..1}
  do
     echo "Wait for container startup... $((60 - $i)) seconds remaining"
     sleep 1
 done

tail -200f /var/log/tomcat7/catalina.out
