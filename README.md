# tf-aws-minecraft
Terraform backed Minecraft server for aws.
Features Auto backup and restore from s3.
Pre-installed and configured mcrcon.


 ## Overview

 * This is a completely self configured self deploying minecraft server for aws cloud

 ## Prerequisites
 * A basic knowledge of terraform , how to apply and run it.
 * A basic understanding of how to configure / setup and use aws cli commands.  You will need to setup appropriate profile
 * Linux experience and AWS account to deploy into.

 NB
 * It is recommended that you setup/and use a remote state. As this is safer and also encrypted at rest.

## Security Exceptions
file name | exception code | reason / justification
---|---|---
sg.tf | tfsec:ignore:aws-vpc-no-public-ingress-sgr | Must be open or players cannot ingress traffic or connect to server
sg.tf | tfsec:ignore:aws-vpc-no-public-egress-sgr | Must be open or the server cannot egress server traffic to connected players
s3.tf | tfsec:ignore:aws-s3-enable-bucket-encryption| According to the docs minecraft world data never contains anything identifiable. NB. my personal aws account prohibits all public bucket access so for me wasnt worth the additional policy work to get the ec2 to be able to access encrypted buckets
s3.tf | tfsec:ignore:aws-s3-encryption-customer-key | According to the docs minecraft world data never contains anything identifiable. NB. my personal aws account prohibits all public bucket access so for me wasnt worth flat $1 per month cost for kms key
s3.tf | tfsec:ignore:aws-s3-enable-bucket-logging | Again not bothereded about logging access to this bucket. Its just additional s3 costs that (for myself) are unwarrented
asg.tf | tfsec:ignore:aws-autoscaling-enforce-http-token-imds | Upstream Module doesn't manage this. I am working on new local launch template override as well as upstream PR for this but for now if you want it to not get stopped by pre-commit tfsec checks this will need to be on ignore.

 ## Versions

 See change log for specifics.

  * 0.#.# >= Pre-Alpha testing phase
  * [0.0.1](https://github.com/kmalkin/tf-aws-minecraft/releases/tag/0.0.1) - Baby Zombie - Pre Release
  * [0.0.2](https://github.com/kmalkin/tf-aws-minecraft/releases/tag/0.0.2) - Baby Zombies - Pre Release

 ## Usage

 ### Setup
 * Checkout the code. Enter the `backend-state` directory and run `terraform init && terraform apply`. This will create the backend remote state objects. Take note of the bucket name output.
 * Then simply run `terraform apply` in the parent terraform directory and provide the variables required. It will create the rest.
 * Or include the variables in a parameter file like `terraform apply --var-file=params/default.tfvars`

 ### Post infra deployment
 * Dont forget you can get a copy of the cert.pem using `terraform output private_generated_key`. It wont show up by default as its flagged as sensitive. So you can then save that as `*.pem` to access the server.
 * Access once you have the cert can be done via `ssh -i "CERT_PATH.pem" ec2-user@IPADDRESS`

### Additional Information / Steps you can do
 * Everything currently runs as root as I needed root access for crontab mangement for the autobackups.
 * The running server itself is bound to a venv `screen` shell. Which can be accessed by `sudo su -` to get to root. Then `screen -r` will reattach to the server. Although I wouldnt recommend this as if you exit wrongly it will terminate the server.
 * Best to access the server via the mcrcon tool that is pre installed.

### Server Performance to Instance Type Findings
 * Solo private server. Will run ok on t*.micro with 512M memory
 * 1-5 player private server. Will run ok on t*.small with 1024M memory
 * 5+ will need to go into the realms of *.medium instances with 2048M and start incurring quite a substantial increase to cost.

 NB
 * I personally wouldn't recommend (and don't intend to myself) use this on larger instance specs till i have finished coding up the spot fleet capability.


 ## Future features
* Ability to use spot fleet setup / asg's
* Ability to add/remove/manage mods

 # !!!! DISCLAIMER !!!!

 All code is currently designed to run within aws. All costs are down to the responsibility of the aws account owner. If you don't know/understand what this is deploying. Dont deploy it. There may be running costs involved with elastic ips/storage/keypairs that you as the aws account owner would be responsible for. I do not take any responsibility for costs incurred by consuming and running this project. Please make sure you understand the aws costings before using this project.
