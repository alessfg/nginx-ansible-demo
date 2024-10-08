# NGINX: Better with Ansible Demo

## Overview

This demo uses Terraform to set up four instances on AWS and then provides a series of Ansible playbooks to install NGINX Plus, configure an NGINX Plus reverse proxy load balancing between a couple NGINX Plus web servers, and install NGINX App Protect and configure NGINX App Protect to secure the NGINX Plus reverse proxy.

A PDF containing accompanying slides for this demo can also be found under the name of [`NGINX Better with Ansible.pdf`](NGINX%20Better%20with%20Ansible.pdf).

## Requirements

### Terraform

This demo has been developed and tested with Terraform `1.3`.

Instructions on how to install Terraform can be found in the [Terraform website](https://www.terraform.io/downloads.html).

### Ansible

This demo has been developed and tested with Ansible `2.16` and Jinja2 `3.1`. Do note you will absolutely need to have Jinja2 `3.1` installed to be able to run the demo.

Instructions on how to install Ansible can be found in the [Ansible website](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

You will also need to download the latest Ansible NGINX roles and the latest Ansible AWS collection (`amazon.aws`). To install the latest versions, you can use:

```bash
ansible-galaxy install -f -r ansible/requirements.yml
```

Finally, in order to use the Amazon AWS (`amazon.aws`) collection, you will also need to install the `boto3` and `botocore` Python packages.

### NGINX Plus (Optional)

If you wish to deploy the more advanced version of this demo, you will need to download an NGINX Plus and NGINX App Protect license from your [MyF5 portal](https://account.f5.com/myf5) before you run this script. Alternatively, a simplified NGINX Open Source version of the demo is also available.

## Demo Setup/Deployment

To use the provided Terraform scripts, you need to:

1. Export your AWS credentials as environment variables (or alternatively, tweak the AWS provider in [`terraform/provider.tf`](/terraform/provider.tf)).
2. Set up default values for variables missing a value in [`terraform/variables.tf`](/terraform/variables.tf) (you can find example values commented out in the file). Alternatively, you can input those variables at runtime (beware of dictionary values if you do the latter).

Once you have configured your Terraform environment, you can either:

* Run [`./setup.sh`](/setup.sh) to initialize the AWS Terraform provider and start a Terraform deployment on AWS:

```bash
./setup.sh
```

* Run `terraform init` and `terraform apply`

```bash
cd terraform && terraform init && terraform apply -auto-approve
```

And finally, once you are done playing with the demo, you can destroy the AWS infrastructure by either:

* Run [`./cleanup.sh`](/cleanup.sh) to destroy your Terraform deployment:

```bash
./destroy.sh
```

* Run `terraform destroy`:

```bash
cd terraform && terraform destroy -auto-approve && rm -f terraform.tfstate terraform.tfstate.backup && rm -rf .terraform
```

## Demo Overview

You will find a series of Ansible playbooks in the [`ansible`](/ansible/) folder. Playbook zero is only used to verify that the AWS EC2 instances launched by Terraform can be successfully pinged from the Ansible host. There are two versions of playbook one. One installs NGINX Plus whilst the other installs NGINX Open Source. You will have to deploy playbook one, [`1-deploy-nginx.yml`](/ansible/1-deploy-nginx.yml), before you attempt to deploy any other playbooks. Playbooks two through four can be deployed in any order, albeit the recommended order gradually configures a more advanced NGINX environment. Do note that if you decide to install NGINX Open Source, you will not be able to deploy playbooks four and five. If you are running the NGINX Plus playbook, you can either tweak the `nginx_license`  variable in playbook one itself, or pass the variable at runtime using Ansible's extra vars (`--extra-vars`/`-e`) CLI command.

To execute a playbook, run:

```bash
ansible-playbook --private-key=</path/to/key> -i ansible/aws_ec2.yml ansible/1-deploy-nginx.yml
```

This demo includes the following playbooks:

| Name | Description |
| ---- | ----------- |
| **[`0-check-platform.yml`](/ansible/0-check-platform.yml)** | Check that all platforms have been deployed correctly by Terraform |
| **[`1-deploy-nginx.yml`](/ansible/1-deploy-nginx.yml)** | Deploy NGINX Plus |
| **[`1-deploy-nginx-oss.yml`](/ansible/1-deploy-nginx.yml)** | Deploy NGINX Open Source |
| **[`2-deploy-nginx-web-server.yml`](/ansible/2-deploy-nginx-web-server.yml)** | Deploy an NGINX Plus web server |
| **[`3-deploy-nginx-web-server-proxy.yml`](/ansible/3-deploy-nginx-web-server-proxy.yml)** | Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers |
| **[`4-deploy-nginx-app-protect-web-server-proxy.yml`](/ansible/4-deploy-nginx-app-protect-web-server-proxy.yml)** | Deploy an NGINX Plus reverse proxy load balancing between two NGINX Plus web servers protected by NGINX App Protect |
| **[`5-check-app-protect.yml`](/ansible/5-check-app-protect.yml)** | Check that NGINX App Protect is working as expected |
| **[`6-deploy-nginx-agent.yml`](/ansible/6-deploy-nginx-agent.yml)** | Deploy NGINX Agent |

>[!NOTE]
> The Ansible AWS inventory file used in the above demos will only work if you used the Terraform script to set up your AWS infrastructure. If you are deploying AWS instances any other way, you will need to tweak the Ansible AWS inventory file accordingly.

## Author Information

[Alessandro Fael Garcia](https://github.com/alessfg)
