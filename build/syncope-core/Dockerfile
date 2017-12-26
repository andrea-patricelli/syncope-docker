FROM ubuntu:16.04

RUN set -x && apt-get update
RUN apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa

#######################
#                     #
# PREPARE ENVIRONMENT #
#                     #
#######################
RUN apt-get  -y install tomcat7 libpostgresql-jdbc-java postgresql postgresql-client openjdk-7-jre

# Clean apt
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

# Download Apache Syncope debs
WORKDIR /

ADD http://mirror.nohup.it/apache/syncope/1.2.10/apache-syncope-1.2.10.deb /apache-syncope-1.2.10.deb
RUN service tomcat8 stop

#Install Apache Syncope from debs
RUN dpkg -i apache-syncope-*.deb && rm apache-syncope-1.2.10.deb

COPY conf/*.properties /etc/apache-syncope/

EXPOSE 8080

CMD ["/startSyncope.sh"]
