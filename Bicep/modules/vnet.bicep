param location string
param vnetName string
param addressPrefix string
param subnetPrefixes object

resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      for key in subnetPrefixes: {
        name: 'subnet-${key}'
        properties: {
          addressPrefix: subnetPrefixes[key]
        }
      }
    ]
  }
}

output nodepool1SubnetId string = vnet::subnets[0].id