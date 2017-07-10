#!/bin/sh

#THIS SCRIPT REQUIRES JQ
#Script to put an instance inside the load balancer

#Put the ELB name
elb="Engage"

#use this in case your profile is not the default. You should you use --profile name_of_profile
profile=" --profile fedilton"

#check json to return instances
resultset=$(aws ec2 describe-instances --profile fedilton | jq -r ".Reservations[] | .Instances[] | .InstanceId")

#check number of instances, -w should be used since sh does not break the lines inside a var
nid=$(echo $resultset | wc -w)

#exit if no instances found
if [ $nid -eq "0" ]
then
	echo "No instances found"
	exit 1
fi

#create a menu, and iterate the var if more than one is found
if [ $nid -gt "1" ]
then
	count=0
	echo "Which instance?"
	#if so print the options
	for i in $resultset
	do
		count=$(($count+1))
		echo "[$count] - $i"
	done
	read -p "Input:" inputinstance
  #check the input
  if [ $inputinstance -gt $nid ] || [ $inputinstance -lt "0" ]
	then
		echo "INVALID CHOICE"
		exit 1
	fi
  resultset=$(echo $resultset | cut -d" " -f${inputinstance})
fi

#run the command
aws elb register-instances-with-load-balancer \
--load-balancer-name $elb \
--instances $resultset $profile



#exit gracefully
exit 0
