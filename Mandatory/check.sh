#!/bin/sh


#Very simple script to check if a server is running as desired
#ip or hostname of the server
ip="54.145.207.20"

#content of the txt file
version="1.0.6"

#path of the file
test_file="version.txt"

#do the check
return_version=$(curl --silent http://${ip}/$test_file)

#If anything different from versions is returned we have an error
if [ "$return_version" == "$version" ]
then
  echo OK
else
  echo ERROR
  exit 1
fi

#exit gracefully
exit 0
