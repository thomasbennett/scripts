#!/bin/bash -x
#title           :wp_update.sh
#description     :This script will backup virtual host`s folders and update WordPress.
#author          :Thomas Bennett (thomasgbennett@gmail.com)
#date            :2014 02 18
#usage           :bash wp_update.sh
#=====================================================================================

CLIENTSDIR="/var/www/html"
BDIR="/var/backups"
BFOLDERS="html/wp-content"
CDATE=$(date +%F)
MAILTO="thomasgbennett@gmail.com"
FSUBJECT="wp_update process error!"


function Fatal () {
    if [ "$?" -ne "0" ] ; then
        echo -e "The script has failed in project $i " | mail -s "$FSUBJECT" "$MAILTO"
        exit 1
    fi
    return 0
}

function UPGRADE () {
    mkdir -p  $BDIR/$CDATE/$i || Fatal
    cd $BDIR/$CDATE/$i || Fatal
    tar zcfP  $i.tgz $CLIENTSDIR/$i/$BFOLDERS  --exclude=cache || Fatal
    cd $CLIENTSDIR/$i/html || Fatal
    wp core update || Fatal
    wp plugin update --all  || Fatal
    wp theme update --all || Fatal
}

for i in $(ls $CLIENTSDIR); do
    if [ -d $CLIENTSDIR/$i/$BFOLDERS ] \
        # && [ "$i" != "www.website.com" ] \
        UPGRADE
    else
        echo 0 >/dev/null
    fi
done

rm -rf `find /srv/backups/ -type d -mtime +15` || Fatal
