resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: dataCollectionRuleName 
  location: <location> 
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
            ..... 
            ..... 
            ..... 
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
              ..... 
              ..... 
          ] 
          name: <eventLogsDataSourceName> 
        } 
      ] 
      syslog: [ 
        { 
          streams: [ 
            'Microsoft-Syslog' 
          ] 
          facilityNames: [ 
            ..... 
            ..... 
            ..... 
          ] 
          logLevels: [ 
            ..... 
            ..... 
            ..... 
          ] 
          name: <sysLogsDataSourceName> 
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
      eventHubsDirect: [  
        {  
        eventHubResourceId: <eventHubInstanceResourceID> 
        name: <eventHubDestinationFriendlyName> 
        } 
      ] 
      storageBlobsDirect: [  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <blobDestinationFriendlyNameForWindPerf>  
          containerName: <containerName>  
        } 
        {  
          storageAccountResourceId: <storageAccountResourceID>  
          name: <blobDestinationFriendlyNameForLinuxPerf>  
          containerName: <containerName>  
        } 
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <blobDestinationFriendlyNameForWindEventLogs>,  
          containerName: <containerName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <blobDestinationFriendlyNameForIIS>  
          containerName: <containerName>  
        } 
        {  
          storageAccountResourceId: <storageAccountResourceID>  
          name: <blobDestinationFriendlyNameForCustomLogs>  
          containerName: <containerName>  
        } 
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <blobDestinationFriendlyNameForSyslog>,  
          containerName: <containerName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID>  
          name: <blobDestinationFriendlyNameForTxtLogs>  
          containerName: <containerName>  
        } 
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <blobDestinationFriendlyNameForJsonLogs>,  
          containerName: <containerName>  
        }  
      ]  
      storageTablesDirect: [  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <tableDestinationFriendlyNameForWindEventLogs>  
          tableName: <tableName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <tableDestinationFriendlyNameForWindPerf>  
          tableName: <tableName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <tableDestinationFriendlyNameForLinuxPerf>  
          tableName: <tableName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <tableDestinationFriendlyNameForSyslog>  
          tableName: <tableName>  
        }  
        {  
          storageAccountResourceId: <storageAccountResourceID> 
          name: <tableDestinationFriendlyNameForCustomLogs>  
          tableName: <tableName>  
        }  
      ]  
    } 
    dataFlows: [ 
      { 
        streams: [ 
          'Microsoft-Perf' 
        ] 
        destinations: [ 
          <eventHubDestinationFriendlyName> 
          <blobDestinationFriendlyNameForWindPerf> 
          <blobDestinationFriendlyNameForLinuxPerf>  
          <tableDestinationFriendlyNameForWindPerf> 
          <tableDestinationFriendlyNameForLinuxPerf> 
        ] 
      } 
      { 
        streams: [ 
          'Microsoft-Event' 
        ] 
        destinations: [ 
          <eventHubDestinationFriendlyName> 
          <blobDestinationFriendlyNameForWindEventLogs>  
          <tableDestinationFriendlyNameForWindEventLogs> 
        ] 
      } 
      { 
        streams: [ 
          'Microsoft-Syslog' 
        ] 
        destinations: [ 
          <eventHubDestinationFriendlyName> 
          <blobDestinationFriendlyNameForSyslog>  
          <tableDestinationFriendlyNameForSyslog>  
        ] 
      } 
      { 
        streams: [ 
          'Microsoft-W3CIISLog' 
        ] 
        destinations: [ 
          <blobDestinationFriendlyNameForIIS> 
        ] 
      } 
      { 
        streams: [ 
          'Custom-<textTableName>' 
        ] 
        destinations: [ 
          <blobDestinationFriendlyNameForTxtLogs> 
          <blobDestinationFriendlyNameForJsonLogs> 
        ] 
      } 
      { 
        streams: [ 
          'Custom-Json-<tableName>' 
        ] 
        destinations: [ 
          <blobDestinationFriendlyNameForTxtLogs> 
          <blobDestinationFriendlyNameForJsonLogs> 
        ] 
      } 
    ] 
  } 
} 
