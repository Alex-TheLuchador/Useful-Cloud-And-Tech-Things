$rgName = Read-Host "Resource group: "
$vnetName = Read-Host "VNet name: "

# using Azure CLI because I like it more than the PowerShell module
az network vnet create --resource-group $rgName --name $vnetName --address-prefix 10.1.0.0/16 --subnet-name "vnet01-subnet01" --subnet-prefix 10.1.1.0/24

# to add a subnet:
# az network vnet subnet create --address-prefixes 10.1.2.0/24 --name "vnet01-subnet02" --resource-group "1-f1789d59-playground-sandbox" --vnet-name "vnet01"