# Log Analytics
This module will deploy a Log Analytics Workspace with solutions.

## Usage
``` bicep

param deploymentName string = concat('logAnalytics', utcNow())

module test './main.bicep' = {
  name: deploymentName
  params: {
    name: 'myLogAnalyticsWorkspace'
    sku: 'PerGB2018'
    retentionInDays: 7
    solutions = [
      {
        name: 'ContainerInsights'
        product: 'OMSGallery/ContainerInsights'
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
  }
}
```