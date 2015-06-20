#!/usr/bin/env bash  

#echo CHECK DATABASE
#var=0;
#mysqlshow -uroot -proot -hdatabase --protocol=TCP &> /dev/null;
#while [ $? == 1 ] && [ $var -lt 10 ]
#do
#        echo "WAIT";
#        sleep 1;
#        var=$((var+1))
#        mysqlshow -uroot -proot -hdatabase --protocol=TCP &> /dev/null ;
#done;
#if [ $? == 1 ]; then
#        echo "ERROR MYSQL"
#        exit 1
#fi                                                                                                                                                                   
                                                                                                                                                                                        
echo SETUP DATABASE

cd /app/                                                                                                                                                       
echo I am in `pwd` 
echo CONFIGURE SYNCOPE DATABASE

mysql -uroot -proot < /app/initializeSyncopeDB.sql                                                                                                                                                
echo START TOMCAT                                                                                                                                                                        

/apache-tomcat-8.0.23/bin/startup.sh                                                                                                                                                                                                                                                                              
