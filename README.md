# ExtractCloudServiceDeployment
Contains a sample PowerShell script to extract the .cscfg and .cspkg file from a classic Cloud Service

# ExtractCloudServicePackage.ps1
This script will allow you to extract the .cscfg file and .cspkg file from an existing classic Cloud Service. This may be useful in order to redeploy the Cloud Service to a different slot or to a different classic Cloud Service if you no longer have access to the source code.

## Inputs
- subscriptionId - Azure subscription ID
- cloudServiceName - The name of the classic Cloud Service
- deploymentName - The name of the deployment that will be extracted.
- storageContainerUrl - The fully qualified URL of an Azure Storage Container where the .cscfg file and .cspkg file will be extracted.

## Prerequisites
- Contributor access to the classic Cloud Service and Azure Storage Account 