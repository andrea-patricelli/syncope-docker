#!/usr/bin/env bash

echo "Startup tomcat..."

service tomcat7 start

echo "Wait for container startup... about 60 seconds remaining"

tail -500f /var/log/tomcat7/catalina.out
