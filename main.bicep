targetScope = 'subscription'

param location string = deployment().location
param namePrefix string = 'saFunkarDet'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'saFunkarDet-2021-rg'
  location: deployment().location
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

module appService 'arm-templates/appService-VNet.bicep' = {
  name: 'appService-deploy'
  scope: rg
  params:{
    appName: 'steffes-webapp'
    location: location
    serverFarmId: serverFarm.outputs.resourceId
    subnetId: vNet.outputs.subnet
  }
}