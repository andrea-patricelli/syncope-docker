FROM monsantoco/min-jessie:latest

RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN set -x && apt-get update

#######################
#                     #
# PREPARE ENVIRONMENT #
#                     #
#######################

RUN apt-get  -y install tomcat8 libpostgresql-jdbc-java postgresql postgresql-client openjdk-8-jre 
#RUN apt-get -y install libpostgresql-jdbc-java openjdk-8-jre

# Clean apt
#RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

# Use the PostgreSQL JDBC driver with Tomcat
RUN ln -s /usr/share/java/postgresql-jdbc4.jar /usr/share/tomcat8/lib/ 

#Get correct Java opts for Tomcat
COPY tomcat8 /etc/default/

COPY startSyncope.sh /
RUN chmod +x /startSyncope.sh

##############################
#                            #
#   INSTALL SYNCOPE CONSOLE  #
#                            #
##############################

# Download Apache Syncope debs
WORKDIR /

ADD http://it.apache.contactlab.it/syncope/2.0.1/apache-syncope-console-2.0.1.deb apache-syncope-console-2.0.1.deb
RUN service tomcat8 stop

#Install Apache Syncope from debs
RUN dpkg -i apache-syncope-*.deb

COPY console.properties /etc/apache-syncope/console.properties

EXPOSE 8080

CMD ["/startSyncope.sh"]
