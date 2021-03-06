Infrastructure Coding Test
==========================

# CAUTION: DO NOT RUN THIS CODE IN PRODUCTION ENVIRONMENT. IT'S A CODING TEST

# Goal

Script the creation of a web server, and a script to check the server is up.

# Prerequisites

You will need an AWS account. Create one if you don't own one already. You can use free-tier resources for this test.

# The Task

You are required to set up a new server in AWS. It must:

* Be publicly accessible.
* Run Nginx.
* Serve a `/version.txt` file, containing only static text representing a version number, for example:

```
1.0.6
```

# Mandatory Work

Fork this repository.

* Provide instructions on how to create the server.
* Provide a script that can be run periodically (and externally) to check if the server is up and serving the expected version number. Use your scripting language of choice.
* Alter the README to contain the steps required to:
  * Create the server.
  * Run the checker script.
* Provide us IAM credentials to login to the AWS account. If you have other resources in it make sure we can only access what is related to this test.

Give our account `engagetech` access to your fork, and send us an email when you’re done. Feel free to ask questions if anything is unclear, confusing, or just plain missing.

# Extra Credit

We know time is precious, we won't mark you down for not doing the extra credits, but if you want to give them a go...

* Use a CloudFormation template to set up the server.
* Use a configuration management tool (such as Puppet, Chef or Ansible) to bootstrap the server.
* Put the server behind a load balancer.
* Run Nginx inside a Docker container.
* Make the checker script SSH into the instance, check if Nginx is running and start it if it isn't.

# Questions

#### What scripting languages can I use?

Anyone you like. You’ll have to justify your decision. We use Bash, Python and JavaScript internally. Please pick something you're familiar with, as you'll need to be able to discuss it.

#### Will I have to pay for the AWS charges?

No. You are expected to use free-tier resources only and not generate any charges. Please remember to delete your resources once the review process is over so you are not charged by AWS.

#### What will you be grading me on?

Scripting skills, ellegance, understanding of the technologies you use, security, documentation.

#### Will I have a chance to explain my choices?

Feel free to comment your code, or put explanations in a pull request within the repo.
If we proceed to a phone interview, we’ll be asking questions about why you made the choices you made.

#### Why doesn't the test include X?

Good question. Feel free to tell us how to make the test better. Or, you know, fork it and improve it!

# Solutions

All the scripts have variables for configuration. No one will accept parameters.
Before use the scripts you should configure your AWS CLI, using JSON as output. Also your default VPC must be there. There are no error treatment on AWS API. So if someone runs the script, should pay attention to the JSON returned.

## Mandatory

### create.sh
Create an instance inside the default VPC, passing bootstrap.sh as a parameter.

### bootstrap.sh
Used by create.sh, but can be used at AWS console. Installs nginx, enable, start and create the version file.

### check.sh
Will check if the version.txt is correct at configured IP/Host

## Extras

### CloudFormation - ec2.json
Launch a t2.micro running Amazon Linux and engage SG. Bootstrap with user data
and outputs Public IP, Private IP and AZ.

### Chef - nginx.rb
Just a simple recipe file for the code challenge. In production you should consider use the packache from chef team. https://supermarket.chef.io/cookbooks/chef_nginx

### ELB - lb.sh
Check if you have instance and put inside a configured elb. If you have more than one instance, will ask you for choose an instance.

### Docker - docker.sh
You must have docker installed and running. Pull nginx image, run detached and expose port 80. Create the version file and copy to the container.

### SSH Check - check_ssh.sh
SSH into the instance and check if there are any nginx process. If not will try to start it once. SSH options are provided to avoid SSH questions.
