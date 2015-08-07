#FROM williamyeh/java7
FROM monsantoco/min-jessie:latest
#FROM ubuntu
#FROM jeanblanchard/java:jre-7

RUN set -x && apt-get update
RUN apt-get install -y unzip

# Download Apache Tomcat 8 and unpackage it
WORKDIR /
ADD http://ftp.heanet.ie/mirrors/www.apache.org/dist/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.zip /apache-tomcat-8.0.23.zip

RUN unzip apache-tomcat-8.0.23.zip
RUN rm apache-tomcat-8.0.23.zip

#Create setenv.sh
COPY setenv.sh /apache-tomcat-8.0.23/bin/

#Set correct context.xml
COPY context.xml /apache-tomcat-8.0.23/conf/

RUN chmod +x /apache-tomcat-8.0.23/bin/*.sh

RUN mkdir -p /app/syncope
RUN mkdir -p /app/syncope/bundles
RUN mkdir -p /app/syncope/log
RUN mkdir -p /app/syncope/conf

RUN apt-get update
RUN apt-get install -y mysql-client

#Install Java JRE 7
RUN apt-get install -y openjdk-7-jre

RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password root | debconf-set-selections
RUN apt-get -y install mysql-server

RUN apt-get clean  && rm -rf /var/lib/apt/lists/*

COPY configureSyncopeDatabase.sh /app/
COPY initializeSyncopeDB.sql /app/ 
RUN chmod +x /app/configureSyncopeDatabase.sh

COPY startSyncope.sh /app/
RUN chmod +x /app/startSyncope.sh

COPY mysql-connector-java-5.1.25-bin.jar /apache-tomcat-8.0.23/lib/
COPY tomcat-jdbc-interceptors-0.4.jar /apache-tomcat-8.0.23/lib/ 

COPY *.war /apache-tomcat-8.0.23/webapps/

VOLUME /var/tmp/syncope-docker

EXPOSE 8080

CMD ["/app/startSyncope.sh"]
