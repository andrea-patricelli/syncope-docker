FROM ubuntu:16.04

RUN set -x && apt-get update

#######################
#                     #
# PREPARE ENVIRONMENT #
#                     #
#######################
RUN apt-get  -y install tomcat8 libpostgresql-jdbc-java postgresql postgresql-client openjdk-8-jre

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

#######################
#                     #
#   INSTALL SYNCOPE   #
#                     #
#######################

# Download Apache Syncope debs
WORKDIR /

ADD http://it.apache.contactlab.it/syncope/2.0.7/apache-syncope-2.0.7.deb apache-syncope-2.0.7.deb
RUN service tomcat8 stop

#Install Apache Syncope from debs
RUN dpkg -i apache-syncope-*.deb && rm apache-syncope-2.0.7.deb

COPY conf/*.properties /etc/apache-syncope/
COPY conf/domains/ /etc/apache-syncope/domains

EXPOSE 8080

CMD ["/startSyncope.sh"]
