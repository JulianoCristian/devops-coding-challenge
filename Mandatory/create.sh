#!/bin/bash

#chose you instance type, remember that some regions don't have all types
instance_type="t2.micro"
#name of your key, here you can't put extension
key_name="engage"
#Image ID, ami-a4c7edb2 is a Amazon Linux
image_id="ami-a4c7edb2"
#SG id
security_group_id="sg-2d650c5c"

#use this in case your profile is not the default. You should you use --profile name_of_profile
profile=" --profile fedilton"

#run-instances will base64 the script
#the script should be in the same folder as this script, otherwise you have to put
#the full path
bootstrap_script="bootstrap.sh"

#create
echo aws ec2 run-instances --image-id $image_id --count 1 \
--instance-type $instance_type --key-name $key_name \
--security-group-ids $security_group_id \
--associate-public-ip-address \
--user-data file://$bootstrap_script \
$profile

#exit gracefully
exit 0
