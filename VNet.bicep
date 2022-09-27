// az deployment group create --resource-group <resource-group-name> --template-file <path-to-bicep>

@description('Location of your Virtual Network.')
param vnetLocation string = resourceGroup().location

var vnetName = 'vnet-01'
var subnet01Name = 'sub-01'
var subnet02Name = 'sub-02'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: vnetName
  location: vnetLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }

    /*
      Creating subnets here is the preferred way.

      Declaring them as child resources can
      have unintented condequences, like network downtime
      https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/scenarios-virtual-networks
    */
    subnets: [
      {
        name: subnet01Name
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnet02Name
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }

  /*
    We reference the subnets so we can assign
    a symbolic name, with which we get the
    resource id.

    We are not declaring the subnets, so we
    do not have the risks that come with
    creating them as child resources.
  */
  resource subnet01 'subnets' existing = {
    name: subnet01Name
  }

  resource subnet02 'subnets' existing = {
    name: subnet02Name
  }
}

output subnet01ResourceId string = virtualNetwork::subnet01.id
output subnet02ResourceId string = virtualNetwork::subnet02.id
