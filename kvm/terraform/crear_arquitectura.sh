echo "##################################################################"
echo "#          DESPLIEGUE ARQUITECTURA KVM (TERRAFORM)               #"
echo "##################################################################"
echo "\n--------------------  DESPLIEGUE NFS ---------------------------"
cd nfs
echo ">> terraform init NFS ..."
terraform init
echo ">> terraform plan NFS ..."
terraform plan
echo ">> terraform apply NFS ..."
terraform apply  -auto-approve
echo "\n\n--------------------  DESPLIEGUE MASTER ---------------------------"
cd ../master
echo ">> terraform init MASTER ..."
terraform init
echo ">> terraform plan MASTER ..."
terraform plan
echo ">> terraform apply MASTER ..."
terraform apply  -auto-approve
echo "\n\n--------------------  DESPLIEGUE WORKERS ---------------------------"
cd ../workers
echo ">> terraform init MASTER ..."
terraform init
echo ">> terraform plan MASTER ..."
terraform plan
echo ">> terraform apply MASTER ..."
terraform apply -auto-approve
echo "===================== FIN DESPLIEGUE ARQUITECTURA ====================="