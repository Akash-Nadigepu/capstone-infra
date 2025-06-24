param profileName string
param endpointName string
param target string
param resourceGroupName string

resource endpoint 'Microsoft.Network/trafficManagerProfiles/externalEndpoints@2022-05-01' = {
  name: '${profileName}/${endpointName}'
  location: 'global'
  properties: {
    target: target
    endpointStatus: 'Enabled'
    endpointLocation: 'Korea Central'
  }
}