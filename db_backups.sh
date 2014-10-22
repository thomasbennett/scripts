#!/bin/bash

# Script Function:
# This bash script backups up the DBs with a file name time stamp and tar.gz zips the file.
# Db backups older than 30 days will be deleted.

cd /var/www/db_bu/

#[Old DB Deletion Script]
find /var/www/db_bu/ -name "*.tar.gz" -mtime +30 -exec rm -f {} \;

#[Stamps the file name with a date]
TIMESTAMP=`date +%m-%d-%y-%H%M`

#[DB Backup Scripts]

# Client
HOST="hostname"
DBNAME="database"
USER="username"
PASSWORD="password"
DUMP_PATH=/var/www/db_bu/
mysqldump --opt -c -e -Q -h$HOST -u$USER -p$PASSWORD $DBNAME > $DBNAME.sql
tar czpf $DUMP_PATH/$DBNAME.$TIMESTAMP.tar.gz $DBNAME.sql
rm -f $DBNAME.sql

# rinse; repeat
