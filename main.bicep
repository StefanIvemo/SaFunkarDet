targetScope = 'subscription'

param location string = deployment().location
param namePrefix string = 'saFunkarDet'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${namePrefix}-2021-rg'
  location: location
}

module vNet 'vnet.bicep' = {
  name: 'vnet-deploy'
  scope: rg
  params: {
    location: location
    namePrefix: namePrefix
  }
}

module serverFarm 'modules/appserviceplan.bicep' = {
  name: 'serverFarm-deploy'
  scope: rg
  params: {
    name: '${namePrefix}-serverFarm'
    location: location
  }
}

var appServices = [
  {
    name: '${namePrefix}-app1'
  }
  {
    name: '${namePrefix}-app2'
  }
]

module appService 'arm-templates/appService-VNet.bicep' = [for app in appServices: {
  name: '${app.name}-deploy'
  scope: rg
  params:{
    appName: app.name
    location: location
    serverFarmId: serverFarm.outputs.resourceId
    subnetId: vNet.outputs.subnet
  }
}]