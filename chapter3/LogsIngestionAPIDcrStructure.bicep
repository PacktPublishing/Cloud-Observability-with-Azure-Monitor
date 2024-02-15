resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: <dataCollectionRuleName> 
  location: <location> 
  properties: { 
    dataCollectionEndpointId: <dataCollectionEndpointID> 
    streamDeclarations: { 
      'Custom-<tableName>': { 
        columns: [ 
          { 
            name: 'timestamp' 
            type: 'datetime' 
          } 
          { 
            name: 'Column01' 
            type: 'string' 
          } 
          { 
            name: 'Column02' 
            type: 'dynamic' 
          } 
        ] 
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
          'Custom-<tableName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: '<transformKQL>' 
        outputStream: 'Custom-<tableName>_CL' 
      } 
      { 
        streams: [ 
          'Custom-<tableName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: '<transformKQL>' 
        outputStream: 'Microsoft-<SupportedTableName>' 
      } 
    ] 
  } 
} 
