Clear-Host

Select-AzureRmSubscription -SubscriptionId "f1766062-4c0b-4112-b926-2508fecc5bdf"

$resourceGroupName = "rgarmsamples"
$storageAccountName = $resourceGroupName
$storageContainer = "uideploy"
$storageAccountKey = (Get-AzureRmStorageAccountKey -Name $storageAccountName -ResourceGroupName $resourceGroupName).Key1
$storageAccountCtx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

$container = Get-AzureStorageContainer -Name $storageContainer -Context $storageAccountCtx -ErrorAction SilentlyContinue

if ($container -eq $null)
{
    New-AzureStorageContainer -Name $storageContainer -Context $storageAccountCtx -Permission Blob   
}

Set-AzureStorageBlobContent -File "createUiDefinition.json" -Container $storageContainer -Context $storageAccountCtx -Force

#https://portal.azure.com/#blade/Microsoft_Azure_Compute/CreateMultiVmWizardBlade/internal_bladeCallId/anything/internal_bladeCallerParams/{"initialData":{},"providerConfig":{"createUiDefinition":"https%3A%2F%2Frgarmsamples.blob.core.windows.net%2Fuideploy%2FcreateUiDefinition.json"}} 


$testResourceGroupName = "rgvnettest1"
New-AzureRmResourceGroup -Name $testResourceGroupName -Location "West US" -Force
New-AzureRmResourceGroupDeployment -ResourceGroupName $testResourceGroupName -TemplateFile "network.json" -TemplateParameterFile "network-new-parameters.json"
#New-AzureRmResourceGroupDeployment -ResourceGroupName $testResourceGroupName -TemplateFile "network.json" -TemplateParameterFile "network-existing-parameters.json"