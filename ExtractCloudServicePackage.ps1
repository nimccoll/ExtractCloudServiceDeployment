#===============================================================================
# Microsoft FastTrack for Azure
# Extract the .cscfg file and .cspkg file for a classic Cloud Service to Azure
# Storage
#===============================================================================
# Copyright © Microsoft Corporation.  All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
# OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE.
#===============================================================================
param(
    [Parameter(Mandatory)]$subscriptionId,
    [Parameter(Mandatory)]$cloudServiceName,
    [Parameter(Mandatory)]$deploymentName,
    [Parameter(Mandatory)]$storageContainerUrl
)
# Login to Azure
Connect-AzAccount

# Set subscription context
Set-AzContext -Subscription $subscriptionId

# Get access token for the ARM management endpoint
$accessToken = Get-AzAccessToken

# Create Authorization header for the HTTP requests
$authHeader = "Bearer " + $accessToken.Token
$head = @{"Authorization"=$authHeader; "x-ms-version"="2012-03-01"; "ContentLength"="0"}

# Define the validation endpoint URL and export endpoint URL
$url = 'https://management.core.windows.net/' + $subscriptionId + '/services/hostedservices/' + $cloudServiceName + '/deployments/' + $deploymentName + '/package?containerUri=' + $storageContainerUrl + '&overwriteExisting=true'
try {
    Write-Host 'Attempting to extract .cscfg file and .cspkg file for classic Cloud Service' $cloudServiceName 'and deployment' $deploymentName -ForegroundColor Green
    $getPackageResponse = Invoke-WebRequest -UseBasicParsing $url -Headers $head -Method POST
    if ($getPackageResponse.StatusCode -eq '202') {
        Write-Host '.cscfg file and .cspkg successfully downloaded to storage' -ForegroundColor Green
    }
    else {
        Write-Host 'Failed to download .cscfg file and .cspkg file to storage' -ForegroundColor Red
        Write-Host 'Status code is' $getPackageResponse.StatusCode -ForegroundColor Red
        Write-Host $getPackageResponse.StatusDescription -ForegroundColor Red
    }
}
catch {
        Write-Host 'Failed to download .cscfg file and .cspkg file to storage' -ForegroundColor Red
        Write-Host $PSItem.ToString() -ForegroundColor Red
}