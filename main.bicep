targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'SaFunkarDet-rg'
  location: deployment().location
}

module appPlanDeploy 'appPlan.bicep' = {
  name: 'appPlanDeploy'
  scope: rg
  params: {
    namePrefix: 'SaFunkarDet'
  }
}

var websites = [
  {
    name:'fancy'
    tag: 'latest'
  }
  {
    name: 'plain'
    tag: 'plain-text'
  }
]

module siteDeploy 'arm-templates/site.bicep' = [for site in websites: {
  name: '${site.name}siteDeploy'
  scope: rg
  params:{
    location: deployment().location
    appPlanId: appPlanDeploy.outputs.planId
    namePrefix: site.name
    dockerImage: 'nginxdemos/hello'
    dockerImageTag: site.tag
  }
}]