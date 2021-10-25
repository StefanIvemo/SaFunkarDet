// Deploys Log Analytics Workspace
@maxLength(8)
param namePrefix string
param location string = resourceGroup().location
param retentionInDays int = 60

var workspaceName = '${namePrefix}${uniqueString(resourceGroup().id)}log'

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  properties: {
    retentionInDays: retentionInDays
  }
}

output resourceId string = workspace.id
output resourceName string = workspace.name
