#!/usr/bin/env bash

echo "Startup tomcat..."

service tomcat8 start

echo "Wait for container startup... about 60 seconds remaining"

tail -500f /var/log/tomcat8/catalina.out
