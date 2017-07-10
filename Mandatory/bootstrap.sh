#!/bin/sh

document_root="/usr/share/nginx/html"

#instal nginx package
yum -y install nginx

#just to make sure nginx will start after a reboot
chkconfig nginx on

#start nginx right now
service nginx start

#create version.txt file
echo 1.0.6 > ${document_root}/version.txt
