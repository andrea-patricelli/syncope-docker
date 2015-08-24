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
ADD http://it.apache.contactlab.it/syncope/1.2.5/apache-syncope-1.2.5.deb /apache-syncope-1.2.5.deb
ADD http://mirrors.muzzy.it/apache/syncope/1.2.5/apache-syncope-console-1.2.5.deb /apache-syncope-console-1.2.5.deb

RUN apt-get  -y install tomcat7 libpostgresql-jdbc-java postgresql postgresql-client openjdk-7-jre

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

#RUN SYNCOPE_USER="syncope" SYNCOPE_PASS="syncope" sh /usr/share/apache-syncope/dbinit-postgresql.sh

#RUN service tomcat7 start

EXPOSE 8080

CMD ["/startSyncope.sh"]
#CMD ["service tomcat7 start"]
