param appName string = uniqueString(resourceGroup().id)
param location string = resourceGroup().location
param serverFarmId string
param subnetId string

resource appName_resource 'Microsoft.Web/sites@2019-08-01' = {
  name: appName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: serverFarmId
  }
}

resource appName_virtualNetwork 'Microsoft.Web/sites/config@2019-08-01' = {
  name: '${appName_resource.name}/virtualNetwork'
  properties: {
    subnetResourceId: subnetId
    swiftSupported: true
  }
}
