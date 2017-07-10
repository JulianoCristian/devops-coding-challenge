#!/bin/sh

document_file="/usr/share/nginx/html/version.txt"
tmp_file="/tmp/dockersh.tmp"
docker_img="nginx"
docker_name="docker-nginx"

#pull nginx official image
docker pull $docker_img

#run the container
docker run --name $docker_name -p 80:80 -d $docker_img

#create tempfile
echo 1.0.6 > $tmp_file

#copy the file into the container
docker cp $tmp_file ${docker_name}:${document_file}

#exit gracefully
exit 0
