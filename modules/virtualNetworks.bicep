// Deploys LandingZone VirtualNetwork
@maxLength(8)
param namePrefix string
param addressPrefix string
param location string = resourceGroup().location

var vnetName = '${namePrefix}${uniqueString(resourceGroup().id)}vnet'
var nsgName = '${namePrefix}${uniqueString(resourceGroup().id)}vnet-snet-default-nsg'
var routeName = '${namePrefix}${uniqueString(resourceGroup().id)}vnet-snet-default-route'

resource defaultNsg 'Microsoft.Network/networkSecurityGroups@2021-03-01' = {
  name: nsgName
  location: location
}

resource defaultRouteTable 'Microsoft.Network/routeTables@2021-03-01' = {
  name: routeName
  location: location
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'snet-default'
        properties: {
          addressPrefix: addressPrefix
          networkSecurityGroup: {
            id: defaultNsg.id
          }
        }
      }
    ]
  }
}

output resourceId string = vnet.id
output resourceName string = vnet.name
