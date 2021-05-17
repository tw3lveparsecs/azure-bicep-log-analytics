# Log Analytics
This module will deploy a Log Analytics Workspace with solutions.

## Usage
``` bicep

param deploymentName string = concat('logAnalytics', utcNow())

module logAnalytics './main.bicep' = {
  name: deploymentName
  params: {
    name: 'myLogAnalyticsWorkspace'
    sku: 'PerGB2018'
    retentionInDays: 30
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
    dataSources: [
      {
        name: 'Application'
        kind: 'WindowsEvent'
        properties: {
          eventLogName: 'Application'
          eventTypes: [
            {
              eventType: 'Error'
            }
            {
              eventType: 'Warning'
            }
          ]
        }
      }
      {
        name: 'LogicalDisk1'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Avg Disk sec/Read'
        }
      }
    ]
  }
}
```