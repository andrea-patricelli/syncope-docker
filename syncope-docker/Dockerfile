#FROM williamyeh/java7
FROM monsantoco/min-jessie:latest
#FROM ubuntu
#FROM jeanblanchard/java:jre-7

RUN set -x && apt-get update
#Install unzip
RUN apt-get install -y unzip

# Download Apache Tomcat 8 and unpackage it
WORKDIR /
ADD http://ftp.heanet.ie/mirrors/www.apache.org/dist/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.zip /apache-tomcat-8.0.23.zip

#Add MySQL connector to Tomcat
ADD http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.21/mysql-connector-java-5.1.21.jar /mysql-connector-java-5.1.21-bin.jar

#Add Tomcat JDBC connection pool jar to Tomcat
ADD http://search.maven.org/remotecontent?filepath=ch/ledcom/tomcat/interceptors/tomcat-jdbc-interceptors/0.4/tomcat-jdbc-interceptors-0.4.jar /tomcat-jdbc-interceptors-0.4.jar

RUN unzip -q apache-tomcat-8.0.23.zip
RUN rm apache-tomcat-8.0.23.zip

#Install downloaded jars on Tomcat
RUN cp mysql-connector-java-5.1.21-bin.jar /apache-tomcat-8.0.23/lib/
RUN cp tomcat-jdbc-interceptors-0.4.jar /apache-tomcat-8.0.23/lib/

#Create setenv.sh
COPY setenv.sh /apache-tomcat-8.0.23/bin/

#Set correct context.xml
COPY context.xml /apache-tomcat-8.0.23/conf/

RUN chmod +x /apache-tomcat-8.0.23/bin/*.sh

RUN mkdir -p /app/syncope
RUN mkdir -p /app/syncope/bundles
RUN mkdir -p /app/syncope/log
RUN mkdir -p /app/syncope/conf

#Install MySQL Client
RUN apt-get update
RUN apt-get install -y mysql-client

#Install Java JRE 7
RUN apt-get install -y openjdk-7-jre

#Install MySQL Server
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password root | debconf-set-selections
RUN apt-get -y install mysql-server

#Final clean
RUN apt-get clean  && rm -rf /var/lib/apt/lists/*

COPY configureSyncopeDatabase.sh /app/
COPY initializeSyncopeDB.sql /app/ 
RUN chmod +x /app/configureSyncopeDatabase.sh

COPY startSyncope.sh /app/
RUN chmod +x /app/startSyncope.sh

#Copy libraries to tomcat
#COPY mysql-connector-java-5.1.25-bin.jar /apache-tomcat-8.0.23/lib/
#COPY tomcat-jdbc-interceptors-0.4.jar /apache-tomcat-8.0.23/lib/ 

#Deploy application
COPY *.war /apache-tomcat-8.0.23/webapps/

#VOLUME /var/tmp/syncope-docker

EXPOSE 8080

CMD ["/app/startSyncope.sh"]
