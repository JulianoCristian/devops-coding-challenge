#!/bin/sh

#TODO: what happens if nginx didn't start
#IP of the server
ip="54.145.207.20"
#Full path of the key, will be used by ssh command
key_name="../engage.pem"
#username used by ssh, this user should be able to sudo
user_name="ec2-user"
#Options to avoid SSH to ask for user interaction
ssh_options="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
#command used to check if nginx processes are running
command="pgrep nginx"
#command to start nginx
start_command="sudo service nginx start"

#check if nginx is running
return_pid=$(ssh $ssh_options -i $key_name $user_name@$ip $command )

#For debug purposes
#echo $return_pid

#check if there are pids
if [ -z "$return_pid" ]
then
  echo Not Running - Trying to start
  #try to start nginx
  ssh $ssh_options -i $key_name $user_name@$ip $start_command
else
  #print pids
  echo Running on PID $return_pid
fi

#exit gracefully
exit 0
