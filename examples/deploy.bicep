param deploymentName string = concat('logAnalytics', utcNow())

module logAnalytics '../main.bicep' = {
  name: deploymentName
  params: {
    name: 'myLogAnalyticsWorkspace'
    sku: 'PerGB2018'
    retentionInDays: 30
    solutions: [
      {
        name: 'AzureActivity'
        product: 'OMSGallery/AzureActivity'
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
        name: 'System'
        kind: 'WindowsEvent'
        properties: {
          eventLogName: 'System'
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
      {
        name: 'LogicalDisk2'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Avg Disk sec/Write'
        }
      }
      {
        name: 'LogicalDisk3'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Current Disk Queue Length'
        }
      }
      {
        name: 'LogicalDisk4'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Disk Transfers/sec'
        }
      }
      {
        name: 'LogicalDisk5'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Disk Writes/sec'
        }
      }
      {
        name: 'LogicalDisk6'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Free Megabytes'
        }
      }
      {
        name: 'LogicalDisk7'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: '% Free Space'
        }
      }
      {
        name: 'LogicalDisk8'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'LogicalDisk'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Disk Reads/sec'
        }
      }
      {
        name: 'Memory1'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Memory'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Available MBytes'
        }
      }
      {
        name: 'Memory2'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Memory'
          instanceName: '*'
          intervalSeconds: 360
          counterName: '% Committed Bytes In Use'
        }
      }
      {
        name: 'Network1'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Network Adapter'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Bytes Received/sec'
        }
      }
      {
        name: 'Network2'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Network Adapter'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Bytes Sent/sec'
        }
      }
      {
        name: 'Network3'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Network Adapter'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Bytes Total/sec'
        }
      }
      {
        name: 'CPU1'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Processor'
          instanceName: '*'
          intervalSeconds: 360
          counterName: '% Processor Time'
        }
      }
      {
        name: 'CPU2'
        kind: 'WindowsPerformanceCounter'
        properties: {
          objectName: 'Processor'
          instanceName: '*'
          intervalSeconds: 360
          counterName: 'Processor Queue Length'
        }
      }
      {
        name: 'LinuxPerformanceCollection'
        kind: 'LinuxPerformanceCollection'
        properties: {
          state: 'Enabled'
        }
      }
      {
        name: 'DiskPerfCounters'
        kind: 'LinuxPerformanceObject'
        properties: {
          objectName: 'Logical Disk'
          instanceName: '*'
          intervalSeconds: 10
          performanceCounters: [
            {
              counterName: '% Used Inodes'
            }
            {
              counterName: 'Free Megabytes'
            }
            {
              counterName: '% Used Space'
            }
            {
              counterName: 'Disk Transfers/sec'
            }
            {
              counterName: 'Disk Reads/sec'
            }
            {
              counterName: 'Disk Writes/sec'
            }
            {
              counterName: 'Disk Read Bytes/sec'
            }
            {
              counterName: 'Disk Write Bytes/sec'
            }
          ]
        }
      }
      {
        name: 'SyslogCollection'
        kind: 'LinuxSyslogCollection'
        properties: {
          state: 'Enabled'
        }
      }
      {
        name: 'auth'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'auth'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'authpriv'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'authpriv'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'mail'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'mail'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'daemon'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'daemon'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'syslog'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'syslog'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'kern'
        kind: 'LinuxSyslog'
        properties: {
          syslogName: 'kern'
          syslogSeverities: [
            {
              severity: 'emerg'
            }
            {
              severity: 'alert'
            }
            {
              severity: 'crit'
            }
            {
              severity: 'err'
            }
            {
              severity: 'warning'
            }
          ]
        }
      }
      {
        name: 'IISLogs'
        kind: 'IISLogs'
        properties: {}
      }
    ]
  }
}
