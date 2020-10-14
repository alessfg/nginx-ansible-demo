# AnsibleFest 2020 - NGINX: Better with Ansible Demo

## Overview

This demo uses Terraform to set up four instances on AWS and then provides a series of Ansible playbooks to install NGINX Plus, configure an NGINX Plus reverse proxy load balancing between a couple NGINX Plus web servers, and install NGINX App Protect and configure NGINX App Protect to secure the NGINX Plus reverse proxy.

## Requirements

### Terraform

This demo has been developed and tested with Terraform `0.13`.

Instructions on how to install Terraform can be found in the [Terraform website](https://www.terraform.io/downloads.html).

### Ansible

This demo has been developed and tested with [maintained](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#release-status) versions of Ansible bigger than `2.9.10`. Backwards compatibility is not guaranteed.

Instructions on how to install Ansible can be found in the [Ansible website](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

## Guide

Before running any playbooks you need to deploy the required AWS infrastructure using Terraform.

You can then run the sample playbooks provided to install and configure NGINX Plus and NGINX App Protect.

### Terraform

To use the provided Terraform scripts, you need to:

1.  Export your AWS credentials as environment variables (or alternatively, tweak the AWS provider in [`terraform/provider.tf`](terraform/provider.tf)).
2.  If you wish to deploy your AWS infrastructure in a different region than the default, `us-west-1`, you will need to tweak the `region` and `ami` variables present in [`terraform/variables.tf`](terraform/variables.tf).

Once you have configured your Terraform environment, you can either:

*   Run [`./setup.sh`](setup.sh) to initialize the AWS Terraform provider and start a Terraform deployment on AWS.
*   Run `terraform init` and `terraform apply` from within the `terraform` directory.

And finally, once you are done playing with the Ansible playbooks provided, you can destroy the AWS infrastructure by either:

*   Run [`./cleanup.sh`](cleanup.sh) to destroy your Terraform deployment.
*   Run `terraform destroy` from within the `terraform directory`.

### Ansible

You can find the playbooks included in the demo in the [`playbooks/`](playbooks/) folder. Playbooks two through four can be deployed in any order, albeit the recommended order gradually configures a more advanced NGINX environment. You will have to deploy playbook one, [`1-deploy-nginx.yml`](playbooks/1-deploy-nginx.yml), before you attempt to deploy any other playbooks.

You can also find an AWS inventory plugin playbook in [`playbooks/aws_ec2.yml`](playbooks/aws_ec2.yml). This plugin will find the instances deployed by Terraform and save them in a temporary inventory list. You can tweak the plugin to your liking with the exception of the `filters` and `keyed_groups` (these are necessary for the Ansible playbooks to work correctly).

To execute a playbook, run:

```
ansible-playbook -i playbooks/aws_ec2.yml playbooks/1-deploy-nginx.yml
```

This demo includes the following playbooks:

|Name|Description|
|----|-----------|
|**[`0-check-platform.yml`](playbooks/0-check-platform.yml)**|Check that all platforms have been deployed correctly by Terraform|
|**[`1-deploy-nginx.yml`](playbooks/1-deploy-nginx.yml)**|Deploy NGINX Plus|
|**[`2-deploy-nginx-web-server.yml`](playbooks/2-deploy-nginx-web-server.yml)**|Deploy an NGINX Plus web server|
|**[`3-deploy-nginx-web-server-proxy.yml`](playbooks/3-deploy-nginx-web-server-proxy.yml)**|Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers|
|**[`4-deploy-nginx-app-protect-web-server-proxy.yml`](playbooks/4-deploy-nginx-app-protect-web-server-proxy.yml)**|Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers protected by NGINX App Protect|
|**[`5-check-app-protect.yml`](playbooks/5-check-app-protect.yml)**|Check that NGINX App Protect is working as expected|

## Author Information

[Alessandro Fael Garcia](https://github.com/alessfg)
