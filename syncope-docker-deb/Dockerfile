FROM williamyeh/java7
#FROM ubuntu

RUN set -x && apt-get update

# Download Apache Tomcat 8 and unpackage it
WORKDIR /
ADD http://it.apache.contactlab.it/syncope/1.2.4/apache-syncope-1.2.4.deb /apache-syncope-1.2.4.deb
ADD http://mirrors.muzzy.it/apache/syncope/1.2.4/apache-syncope-console-1.2.4.deb /apache-syncope-console-1.2.4.deb

RUN apt-get  -y install tomcat7 libpostgresql-jdbc-java postgresql postgresql-client

RUN ln -s /usr/share/java/postgresql-jdbc4.jar /usr/share/tomcat7/lib/

COPY tomcat7 /etc/default/

RUN service tomcat7 stop

RUN dpkg -i apache-syncope-*.deb

#RUN rm /usr/local/var/postgres/postmaster.pid

RUN mkdir -p /var/pgsql_socket/ 
RUN ln -s /var/run/postgresql/.s.PGSQL.5432 /var/pgsql_socket/

RUN SYNCOPE_USER="syncope" SYNCOPE_PASS="syncope" sh /usr/share/apache-syncope/dbinit-postgresql.sh

RUN service tomcat7 start

EXPOSE 8080

CMD ["service tomcat7 start"]
