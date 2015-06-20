CREATE USER 'syncope'@'localhost' IDENTIFIED BY 'syncope';

CREATE DATABASE IF NOT EXISTS syncope;

GRANT ALL PRIVILEGES ON syncope.* TO 'syncope'@'localhost' ;
