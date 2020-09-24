cd terraform \
&& rm -rf .terraform \
&& terraform init \
&& yes yes | terraform destroy \
&& yes yes | terraform apply
