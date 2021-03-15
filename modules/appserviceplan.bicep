param name string
param location string = resourceGroup().id
param sku string = 'S1'
param kind string = 'kind'

resource serverFarm 'Microsoft.Web/serverfarms@2019-08-01' = {
  name: name
  location: location
  sku: {
    name: 'S1'
  }
  kind: 'app'
}

output resourceId string = serverFarm.id