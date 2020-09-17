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

- Ensure you have installed and configured aws-vault. More info: https://github.com/99designs/aws-vault

- Go to AWS Marketplace search for Kali and open a subscription.

- Ensure you are using terraform `0.12.3`

- Assume the role of the aws account you wish to deploy to at your cli. If this is your first time, you will need to create an access key on the `gds-users` account to be able to assume role programatically. See aws doc: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey

*Note that this has already been done for the `security-vuln-testing` aws account. If you are using another aws account, ensure you change line 6 on https://github.com/alphagov/penetration-testing-instance/blob/readme-update/terraform/main.tf to replace the s3 bucket name. Create the bucket manually before running the terraform template.*

### Deploy with the below commands

- Clone this GitHub repository:
`git clone git@github.com:alphagov/penetration-testing-instance.git`

- `cd penetration-testing-instance/terraform`

- edit main.tf and place in your public ssh-key at ssh-pub-key-{number}. Note for MAC users: run `ssh-add -L` to get your public key.   

- `terraform init; terraform plan`

*AWS Vault: `aws-vault exec <profile> -- terraform init; terraform plan`*

- If the plan looks good then run:
`aws-vault exec <profile> -- terraform apply`

- The public IP will be output by TF

- Once the instance is up, to access use:
`ssh pentester@<public-ip-address>`

- Once you have finihed with the Kali instance, destroy it:
`aws-vault exec <profile> -- terraform destroy`

## How to set up GUI on EC2 Kali Linux instance

### Pre-requisite:
- Install VNC Viewer in you MAC: https://www.realvnc.com/en/connect/download/viewer/macos/
- Use OS Kali Linux VERSION="2020.1". To see the version, run `cat /etc/os-release`

### Run the following commands:
- Set up a password for the VNC server in the EC2 Kali Linux instance. Run: `tightvncpasswd` and then `exit` the ssh session.
- Re-connect again to the Kali instance via SSH: `ssh -L 5901:localhost:5901 pentester@<public-ip-address>`
- Start the VNC server in Kali `vncserver`
- On your MAC, execute the VNC viewer software and type `localhost:1` in the search bar. This will prompt the password that was set up previosuly to access the VNC server.

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
