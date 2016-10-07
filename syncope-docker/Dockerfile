#FROM williamyeh/java7
FROM monsantoco/min-jessie:latest

RUN set -x && apt-get update

#######################
#                     #
# PREPARE ENVIRONMENT #
#                     #
#######################

# Download Apache Syncope debs
WORKDIR /
ADD http://mirror.nohup.it/apache/syncope/1.2.8/apache-syncope-1.2.8.deb /apache-syncope-1.2.8.deb
ADD http://mirror.nohup.it/apache/syncope/1.2.8/apache-syncope-console-1.2.8.deb /apache-syncope-console-1.2.8.deb

#RUN apt-get  -y install tomcat7 libpostgresql-jdbc-java postgresql postgresql-client openjdk-7-jre
RUN apt-get  -y install tomcat7 libpostgresql-jdbc-java openjdk-7-jre

# Clean apt
RUN rm -rf /var/lib/apt/lists/*

# Use the PostgreSQL JDBC driver with Tomcat
RUN ln -s /usr/share/java/postgresql-jdbc4.jar /usr/share/tomcat7/lib/

#Get correct Java opts for Tomcat
COPY tomcat7 /etc/default/

COPY startSyncope.sh /
RUN chmod +x /startSyncope.sh

#######################
#                     #
#   INSTALL SYNCOPE   #
#                     #
#######################

RUN service tomcat7 stop

#Install Apache Syncope from debs
RUN dpkg -i apache-syncope-*.deb

COPY persistence.properties /etc/apache-syncope/persistence.properties

EXPOSE 8080

CMD ["/startSyncope.sh"]
