echo "##################################################################"
echo "#          DESPLIEGUE ARQUITECTURA AZURE (TERRAFORM)               #"
echo "##################################################################"
echo ">> terraform init ..."
terraform init
echo ">> terraform plan ..."
terraform plan
echo ">> terraform apply ..."
terraform apply