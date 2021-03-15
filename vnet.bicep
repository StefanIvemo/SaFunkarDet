param namePrefix string
param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: '${namePrefix}-vnet'
  location: location
  properties:{
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/24'
      ]
    }
    subnets: [
      {
        name: 'snet-storage'
        properties:{
          addressPrefix: '10.10.0.0/26'
        }
      }
    ]
  }
}

output subnet string = vnet.properties.subnets[0].id