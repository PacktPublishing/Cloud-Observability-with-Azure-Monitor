param location string = resourceGroup().location 
param dataCollectionRuleName string = 'dcr-packt' 
param dataCollectionEndpointID string = '/subscriptions/<subscription_id>/resourceGroups/rg-packt/providers/Microsoft.Insights/dataCollectionEndpoints/packt-logs-ingestion' 
param workspaceName string = 'law-packt' 
param workspaceResourceID string = '/subscriptions/<subscription_id>/resourceGroups/rg-packt/providers/microsoft.operationalinsights/workspaces/law-packt' 

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = { 
  name: dataCollectionRuleName 
  location: location 
  properties: { 
    dataCollectionEndpointId: dataCollectionEndpointID 
    streamDeclarations: { 
      'Custom-PacktTable': { 
        columns: [ 
          { 
            name: 'timestamp' 
            type: 'datetime' 
          } 
          { 
            name: 'hostname' 
            type: 'string' 
          } 
          { 
            name: 'eventMessage' 
            type: 'dynamic' 
          } 
        ] 
      } 
    } 
    dataSources: {} 
    destinations: { 
      logAnalytics: [ 
        { 
          workspaceResourceId: workspaceResourceID 
          name: workspaceName 
        } 
      ] 
    } 
    dataFlows: [ 
      { 
        streams: [ 
          'Custom-PacktTable' 
        ] 
        destinations: [ 
          workspaceName 
        ] 
        transformKql: 'source\n| extend TimeGenerated = timestamp\n| project-away timestamp\n' 
        outputStream: 'Custom-PacktTable_CL' 
      } 
    ] 
  } 
} 

output dataCollectionRuleID string = dataCollectionRule.id
