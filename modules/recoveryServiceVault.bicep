// Deploys Recovery Service Vault
@maxLength(8)
param namePrefix string
param location string = resourceGroup().location

var vaultName = '${namePrefix}${uniqueString(resourceGroup().id)}vault'

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2021-08-01' = {
  name: vaultName
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

output resourceId string = recoveryServiceVault.id
output resourceName string = recoveryServiceVault.name
