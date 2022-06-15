#! /bin/sh
find /home/webminas/share.onn.li/dist/file/ -mmin +1440 -exec rm -f {} \;
if [ ! -f .htaccess ]
then
    echo "RemoveType .php" > /home/webminas/share.onn.li/dist/file/.htaccess
fi