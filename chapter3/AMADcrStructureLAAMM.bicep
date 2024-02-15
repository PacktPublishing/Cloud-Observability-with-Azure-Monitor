resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: <dataCollectionRuleName> 
  location: <location> 
  kind: <kind> 
  properties: { 
    dataCollectionEndpointId: <dataCollectionEndpointID> 
    streamDeclarations: { 
      'Custom-<textTableName>': { 
        columns: [ 
          { 
            name: 'TimeGenerated' 
            type: 'datetime' 
          } 
          { 
            name: 'RawData' 
            type: 'string' 
          } 
        ] 
      } 
      'Custom-<jsonTableName>': { 
        columns: [ 
          { 
            name: 'TimeGenerated' 
            type: 'datetime' 
          } 
          { 
            name: 'RawData' 
            type: 'string' 
          } 
        ] 
      } 
    } 
    dataSources: { 
      performanceCounters: [ 
        { 
          streams: [ 
            'Microsoft-Perf' 
            'Microsoft-InsightsMetrics' 
          ] 
          samplingFrequencyInSeconds: 60 
          counterSpecifiers: [ 
            '\\System\\Processes' 
            '\\Process(_Total)\\Thread Count' 
            '\\Process(_Total)\\Handle Count' 
            '\\System\\System Up Time' 
            '\\System\\Context Switches/sec' 
            '\\System\\Processor Queue Length' 
            '\\Memory\\% Committed Bytes In Use' 
            '\\Memory\\Available Bytes' 
                      ...... 
                      ...... 
                      ...... 
                     ] 
          name: <perfCounterDataSourceName> 
        } 
      ] 
      windowsEventLogs: [ 
        { 
          streams: [ 
            'Microsoft-Event' 
          ] 
          xPathQueries: [ 
            '<XPath1>' 
            '<XPath2>' 
            .......... 
            .......... 
            .......... 
          ] 
          name: <eventLogsDataSource> 
        } 
      ] 
      syslog: [ 
        { 
          streams: [ 
            'Microsoft-Syslog' 
          ] 
          facilityNames: [ 
            'alert' 
            'audit' 
            ....... 
            ....... 
            .......    
          ] 
          logLevels: [ 
            'Debug' 
            'Info' 
            ....... 
            ....... 
            ....... 
          ] 
          name: '<sysLogsDataSourceName>' 
        } 
      ] 
      logFiles: [  
        {  
          streams: [  
            'Custom-<textTableName>' 
          ] 
          filePatterns: [  
            '<C:\\directoryName\\fileName.txt>'  
          ] 
          format: 'text' 
          settings: {  
              text: {  
              recordStartTimestampFormat: 'ISO 8601'  
              }  
            }  
          name: 'packtTextLogs'  
        }  
        {  
          streams: [  
           'Custom-<jsonTableName>' 
          ] 
          filePatterns: [  
            '<C:\\directoryName\\fileName.json>'  
          ] 
          format: 'text' 
          settings: {  
            text: {  
              recordStartTimestampFormat: 'ISO 8601'  
            }  
          }  
          name: 'packtJsonLogs'  
        }  
      ] 
      iisLogs: [ 
        { 
          streams: [ 
            'Microsoft-W3CIISLog' 
          ] 
          name: <iisLogsDataSourceName> 
        } 
      ] 
    } 
    destinations: { 
      logAnalytics: [ 
        { 
          workspaceResourceId: <workspaceResourceID> 
          name: <workspaceName> 
        } 
      ] 
      azureMonitorMetrics: { 
        name: 'azureMonitorMetrics-default' 
      } 
    } 
    dataFlows: [ 
      { 
        streams: [ 
          'Microsoft-InsightsMetrics' 
        ] 
        destinations: [ 
          'azureMonitorMetrics-default' 
        ] 
      } 
      { 
        streams: [ 
          'Microsoft-Perf' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
      } 
      { 
        streams: [ 
          'Microsoft-Event' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
      } 
      { 
        streams: [ 
          'Microsoft-Syslog' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
      } 
      { 
        streams: [ 
          'Microsoft-W3CIISLog' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
      } 
      { 
        streams: [ 
          'Custom-<textTableName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
        outputStream: 'Custom-<textTableName>_CL' 
      } 
      { 
        streams: [ 
          'Custom-<jsonTableName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL> 
        outputStream: 'Custom-<jsonTableName>_CL' 
      } 
    ] 
  } 
}
