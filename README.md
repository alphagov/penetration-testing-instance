# Penetration Testing Instance  

## Kali Distribution  
Kali is a Debian based distribution that is loaded with penetration testing tools.

## Penetration Testing Tooling  
A list of the tooling that comes with the Kali distro and the extras that we have bundled.  

## What will be deployed?
- A new VPC to hold the Kali EC2 Instance
- An Internet Gateway to allow outbound access
- Routing table to allow outbound access
- An ec2 instance running the Kali distribution
- Security Group allowing 22 inbound from the GDS office IPs
- Security Group allows all outbound
- A CloudInit scipt to install some extra tooling

## How to deploy this Pentesting Instance?

### Pre-requisite:
Within the AWS account you wish to deploy to.

- Go to AWS Marketplace search for Kali and open a subscription.

- Assume the role of the aws account you wish to deploy to at your cli.

*Note that this has already been done for the security-testing aws account*

### Deploy with the below commands
- git clone git@github.com:alphagov/penetration-testing-instance.git

- cd penetration-testing-instance/terraform

- edit main.tf and place in your public ssh-key at ssh-pub-key-1.  
If you are working as a pair also set ssh-pub-key-2.

- terraform init; terraform plan

*AWS Vault: aws-vault exec <profile> -- terraform init; terraform plan*

- If the plan looks good then run:
terraform apply

- To obtain the public ip address run aws-vault exec <profile> -- aws ec2 describe-instances | grep 'GroupName\|PublicIp' 

- Once the instance is up, to access use:
ssh pentester@<public-ip-address>

## Cheatsheet to get started on some of the tooling
CHEATSHEET FOR TOOLING

## Standing up Vulnerable Environments for Testing
You should standup any vulnerable environments or instances in an separate account.
You should have firewalls/security groups configured only allowing your scanning instance inbound to the vulnerable environment.

We have used EC2 instances with Docker installed and run vulnerable Docker Containers.
There are lots of vulnerable docker containers on this repo, with a readme showing how to get things up and running:.
https://github.com/vulhub/vulhub

Metasploitable Vulnerable images can also be found here: https://metasploit.help.rapid7.com/docs/metasploitable-2

## Extra links on the tooling
