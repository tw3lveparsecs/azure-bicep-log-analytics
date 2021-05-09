param location string = resourceGroup().location
param name string
@allowed([
  'PerGB2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
param sku string = 'Free'
param retentionInDays int = 7
param solutions array = [
  {
    name: 'ContainerInsights'
    product: 'OMSGallery/ContainerInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'SQLVulnerabilityAssessment'
    product: 'OMSGallery/SQLVulnerabilityAssessment'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'VMInsights'
    product: 'OMSGallery/VMInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'KeyVaultAnalytics'
    product: 'OMSGallery/KeyVaultAnalytics'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'AzureSQLAnalytics'
    product: 'OMSGallery/AzureSQLAnalytics'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'Containers'
    product: 'OMSGallery/Containers'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'SQLAssessment'
    product: 'OMSGallery/SQLAssessment'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    name: 'Updates'
    product: 'OMSGallery/Updates'
    publisher: 'Microsoft'
    promotionCode: ''
  }
]

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: name
  location: location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
  }
}

resource logAnalyticsSolutions 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = [for solution in solutions: {
  name: concat(solution.name, '(', logAnalyticsWorkspace.name, ')')
  location: location
  properties: {
    workspaceResourceId: logAnalyticsWorkspace.id
  }
  plan: {
    name: concat(solution.name, '(', logAnalyticsWorkspace.name, ')')
    product: solution.product
    publisher: solution.publisher
    promotionCode: solution.promotionCode
  }
}]
