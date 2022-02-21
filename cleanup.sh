cd terraform \
&& terraform destroy -auto-approve \
&& rm terraform.tfstate terraform.tfstate.backup \
&& rm -rf .terraform
