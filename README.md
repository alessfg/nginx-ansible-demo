# NGINX: Better with Ansible Demo

## Overview

This demo uses Terraform to set up four instances on AWS and then provides a series of Ansible playbooks to install NGINX Plus, configure an NGINX Plus reverse proxy load balancing between a couple NGINX Plus web servers, and install NGINX App Protect and configure NGINX App Protect to secure the NGINX Plus reverse proxy.

## Requirements

### Terraform

This demo has been developed and tested with Terraform `0.13.x`. Backwards compatibility is not guaranteed.

Instructions on how to install Terraform can be found in the [Terraform website](https://www.terraform.io/downloads.html).

### Ansible

This demo has been developed and tested with Ansible `2.10.x`. Backwards compatibility is not guaranteed.

Instructions on how to install Ansible can be found in the [Ansible website](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

You will also need to download the Ansible NGINX collection. To install the latest version tested in this demo, you can use:

```
ansible-galaxy collection install -r ansible/requirements.yml
```

Alternatively, to install the latest stable version, you can use:

```
ansible-galaxy collection install nginxinc.nginx_core -f
```

### NGINX Plus

You will need to download your NGINX Plus and NGINX App Protect license from your [MyF5 portal](https://account.f5.com/myf5) before you run this script.

## Guide

Before running any playbooks you need to deploy the required AWS infrastructure using Terraform.

You can then run the sample playbooks provided to install and configure NGINX Plus and NGINX App Protect.

### Terraform

You can find the Terraform scripts included in the demo in the [`terraform/`](terraform/) directory. To use the provided Terraform scripts, you need to:

1.  Export your AWS credentials as environment variables (or alternatively, tweak the AWS provider in [`terraform/provider.tf`](terraform/provider.tf)).
2.  You will need to specify a `key_name` in [`terraform/variables.tf`](terraform/variables.tf) to determine how Ansible ssh's into your AWS instances (or, alternatively, use one of the many methods supported by Terraform to input variables). If you wish to deploy your AWS infrastructure in a different region than the default, `us-west-1`, you will need to tweak the `region` and `ami` variables too.

Once you have configured your Terraform environment, you can either:

*   Run [`./setup.sh`](setup.sh) to initialize the AWS Terraform provider and start a Terraform deployment on AWS.
*   Run `terraform init` and `terraform apply` from within the `terraform` directory.

And finally, once you are done playing with the Ansible playbooks provided, you can destroy the AWS infrastructure by either:

*   Run [`./cleanup.sh`](cleanup.sh) to destroy your Terraform deployment.
*   Run `terraform destroy` from within the `terraform` directory (you can optionally delete your `.terraform` directory too).

### Ansible

You can find the playbooks included in the demo in the [`ansible/`](ansible/) directory. Playbooks two through four can be deployed in any order, albeit the recommended order gradually configures a more advanced NGINX environment. You will have to deploy playbook one, [`1-deploy-nginx.yml`](ansible/1-deploy-nginx.yml), before you attempt to deploy any other playbooks; playbook one also requires the path to a valid NGINX Plus/NGINX App Protect license. You can either tweak the `nginx_license`  variable in the playbook itself, or pass the variable at runtime using Ansible's extra vars (`--extra-vars`/`-e`) CLI command.

You can also find an AWS inventory plugin playbook in [`ansible/aws_ec2.yml`](ansible/aws_ec2.yml). This plugin will find the instances deployed by Terraform and save them in a temporary inventory list. You can tweak the plugin to your liking with the exception of the `filters` and `keyed_groups` (these are necessary for the Ansible playbooks to work correctly).

To execute a playbook, run:

```
ansible-playbook --private-key=</path/to/key> -i ansible/aws_ec2.yml ansible/1-deploy-nginx.yml
```

This demo includes the following playbooks:

|Name|Description|
|----|-----------|
|**[`0-check-platform.yml`](ansible/0-check-platform.yml)**|Check that all platforms have been deployed correctly by Terraform|
|**[`1-deploy-nginx.yml`](ansible/1-deploy-nginx.yml)**|Deploy NGINX Plus|
|**[`2-deploy-nginx-web-server.yml`](ansible/2-deploy-nginx-web-server.yml)**|Deploy an NGINX Plus web server|
|**[`3-deploy-nginx-web-server-proxy.yml`](ansible/3-deploy-nginx-web-server-proxy.yml)**|Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers|
|**[`4-deploy-nginx-app-protect-web-server-proxy.yml`](ansible/4-deploy-nginx-app-protect-web-server-proxy.yml)**|Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers protected by NGINX App Protect|
|**[`5-check-app-protect.yml`](ansible/5-check-app-protect.yml)**|Check that NGINX App Protect is working as expected|

## Author Information

[Alessandro Fael Garcia](https://github.com/alessfg)
