targetScope = 'subscription'

param location string = 'koreacentral'
param resourceGroupName string = 'rg-secondary'

module vnetModule 'modules/vnet.bicep' = {
  name: 'vnetSecondaryDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    vnetName: 'secondary-vnet'
    addressPrefix: '10.20.0.0/16'
    subnetPrefixes: {
      nodepool1: '10.20.1.0/24'
      nodepool2: '10.20.2.0/24'
    }
  }
}

module aksModule 'modules/aks.bicep' = {
  name: 'aksSecondaryDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    aksName: 'aks-secondary'
    dnsPrefix: 'akssecondary'
    subnetId: vnetModule.outputs.nodepool1SubnetId
  }
}

module trafficManagerEndpointModule 'modules/traffic-endpoint.bicep' = {
  name: 'trafficEndpointSecondary'
  scope: resourceGroup(resourceGroupName)
  params: {
    profileName: 'tm-primary'
    endpointName: 'aks-secondary-endpoint'
    target: 'aks-secondary.koreacentral.cloudapp.azure.com' // or update as needed
    resourceGroupName: resourceGroupName
  }
}