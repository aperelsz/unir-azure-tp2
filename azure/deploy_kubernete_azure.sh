echo "##################################################################"
echo "#          DESPLIEGUE ARQUITECTURA AZURE (TERRAFORM)             #"
echo "##################################################################"
cd terraform
echo "Directorio de ejecucion Terraform:" 
echo ">> " "$(pwd)"
echo "" 
echo ">> terraform init ..."
terraform init
echo ">> terraform plan ..."
terraform plan
echo ">> terraform apply ..."
terraform apply -auto-approve
echo ""
echo ""
echo ""
echo ""
echo "##################################################################"
echo "#          DESPLIEGUE KUBERNETE + JENKINS (ANSIBLE)              #"
echo "##################################################################"
cd ..
cd ansible
echo "Directorio de ejecucion Ansible:" 
echo ">> " "$(pwd)"
echo "" 
echo ">> Inicia ejecucion de ansible ..."
ansible-playbook -i hosts -l kubernete install_kubernete.yaml
echo ">> Finalizo ejecucion de Ansible ..."
echo ""
echo ""
cd ..
cat filename resumen.out
echo ""
echo ""




