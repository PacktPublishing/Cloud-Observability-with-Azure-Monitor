resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: <dataCollectionRuleName> 
  location: <location> 
  identity: { 
    type: 'SystemAssigned' 
  } 
  properties: { 
    dataCollectionEndpointId: <dataCollectionEndpointID> 
    streamDeclarations: { 
      'Custom-<StreamName>': { 
        columns: [ 
          { 
            name: 'TimeGenerated' 
            type: 'datetime' 
          } 
          { 
            name: 'RawData' 
            type: 'string' 
          } 
          { 
            name: 'Properties' 
            type: 'dynamic' 
          } 
        ] 
      } 
    } 
    dataSources: { 
      dataImports: { 
        eventHub: { 
          name: '<eventHubDataSourceFriendlyName>' 
          stream: 'Custom-<streamName>' 
          consumerGroup: '<eventHubConsumerGroupName>' 
        } 
      } 
    } 
    destinations: { 
      logAnalytics: [ 
        { 
          workspaceResourceId: <workspaceResourceID> 
          name: <workspaceName> 
        } 
      ] 
    } 
    dataFlows: [ 
      { 
        streams: [ 
          'Custom-<streamName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: <transformKQL>' 
        outputStream: 'Custom-<tableName>_CL' 
      } 
    ] 
  } 
} 
