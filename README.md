# syncope-docker

This is a sample project to have an Apache Syncope project in a Docker container.
You just have to go under directory `syncope-docker` and to run:
``
docker build -t syncope-docker .
``

From now you have also to provide two (well configured) syncope wars (in the syncope-docker directory, we omitted to commit them for obvious reasons): `syncope.war` and `syncope-console.war`.
You have to build them with installation path `/app/syncope`. 
