echo "##################################################################"
echo "#          DESTRUYE ARQUITECTURA AZURE (TERRAFORM)               #"
echo "##################################################################"
cd terraform
echo "Directorio de ejecucion Terraform:" 
echo ">> " "$(pwd)"
echo "" 
echo ">> terraform destroy ..."
terraform destroy
echo ">> finalizo la destruccion de la arquitectura ..."
