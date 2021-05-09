# Log Analytics
This module will deploy a Log Analytics Workspace.

## Usage
``` bicep

param deploymentName string = concat('logAnalytics', utcNow())

module test './main.bicep' = {
  name: deploymentName
  params: {
    name: 'myLogAnalyticsWorkspace'
    sku: 'PerGB2018'
    retentionInDays: 7
  }
}
```