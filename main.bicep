@description('Location of the workspace')
param location string = resourceGroup().location

@description('Name of the workspace')
param name string

@allowed([
  'PerGB2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
@description('Sku of the workspace')
param sku string

@description('The workspace data retention in days, between 30 and 730')
@minValue(7)
@maxValue(730)
param retentionInDays int

@description('Solutions to add to workspace')
@metadata({
  name: 'Solution name'
  product: 'Product name, e.g. OMSGallery/AzureActivity'
  publisher: 'Publisher name'
  promotionCode: 'Promotion code if applicable'
})
param solutions array = []

@description('Resource id of automation account to link to workspace')
param automationAccountId string = ''

@description('Datasources to add to workspace')
@metadata({
  name: 'Data source name'
  kind: 'Data source kind'
  properties: 'Object containing data source properties'
})
param dataSources array = []

@description('Saved searches to add to workspace')
@metadata({
  name: 'Saved search name'
  category: 'The category of the saved search'
  displayName: 'Saved search display name'
  query: 'The query expression for the saved search'
  functionAlias: 'The function alias if query serves as a function'
  functionParameters: 'The optional function parameters if query serves as a function'
})
param savedSearches array = []

@description('Enable lock to prevent accidental deletion')
param enableDeleteLock bool = false

@description('Enable diagnostic logs')
param enableDiagnostics bool = false

@description('Storage account resource id. Only required if enableDiagnostics is set to true.')
param diagnosticStorageAccountId string = ''

var lockName = '${logAnalyticsWorkspace.name}-lck'
var diagnosticsName = '${logAnalyticsWorkspace.name}-dgs'

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
  name: '${solution.name}(${logAnalyticsWorkspace.name})'
  location: location
  properties: {
    workspaceResourceId: logAnalyticsWorkspace.id
  }
  plan: {
    name: '${solution.name}(${logAnalyticsWorkspace.name})'
    product: solution.product
    publisher: solution.publisher
    promotionCode: solution.promotionCode
  }
}]

resource logAnalyticsAutomation 'Microsoft.OperationalInsights/workspaces/linkedServices@2020-08-01' = if (!empty(automationAccountId)) {
  name: '${logAnalyticsWorkspace.name}/Automation'
  properties: {
    resourceId: automationAccountId
  }
}

resource logAnalyticsDataSource 'Microsoft.OperationalInsights/workspaces/dataSources@2020-08-01' = [for dataSource in dataSources: {
  name: '${logAnalyticsWorkspace.name}/${dataSource.name}'
  kind: dataSource.kind
  properties: dataSource.properties
}]

resource logAnalyticsSavedSearch 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = [for savedSearch in savedSearches: {
  name: savedSearch.name
  parent: logAnalyticsWorkspace
  properties: {
    category: savedSearch.category
    displayName: savedSearch.displayName
    functionAlias: contains(savedSearch, 'functionAlias') ? savedSearch.functionAlias : null
    functionParameters: contains(savedSearch, 'functionParameters') ? savedSearch.functionParameters : null
    query: savedSearch.query
    version: contains(savedSearch, 'version') ? savedSearch.version : 2
  }
}]

resource lock 'Microsoft.Authorization/locks@2016-09-01' = if (enableDeleteLock) {
  name: lockName
  scope: logAnalyticsWorkspace
  properties: {
    level: 'CanNotDelete'
  }
}

resource diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = if (enableDiagnostics) {
  name: diagnosticsName
  scope: logAnalyticsWorkspace
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    storageAccountId: diagnosticStorageAccountId
    logs: [
      {
        category: 'Audit'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

output name string = logAnalyticsWorkspace.name
output id string = logAnalyticsWorkspace.id
