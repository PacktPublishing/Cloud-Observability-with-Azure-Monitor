resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: <dataCollectionRuleName> 
  location: <location> 
  kind: 'WorkspaceTransforms' 
  properties: { 
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
          'Microsoft-Table-<tableName>' 
        ] 
        destinations: [ 
          <workspaceName> 
        ] 
        transformKql: 'transformKQL' 
        outputStream: 'Microsoft-<tableName>' 
      } 
    ] 
  } 
}
