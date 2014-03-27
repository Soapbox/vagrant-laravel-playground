SET GLOBAL max_connections = 1024;
SET GLOBAL max_connect_errors = 1024;

GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;

CREATE DATABASE vlplayground;
