param (
    #https://raw.githubusercontent.com/rafaelgodinho/ARMSamples/master/VirtualNetworkNewOrExisting/network.json
    [Parameter(Mandatory=$true)][string]$MainTemplateUri,
    [Parameter(Mandatory=$true)][string]$ParametersFolder,
    [Parameter(Mandatory=$true)][string]$OutputFolder,
    [string]$resourceGroupBaseName = "myrgname",
    [string]$deploymentBaseName = "deploy"
 )

#Helper functions to collect the logs.
. ./AzureHelpers.ps1

Clear-Host

$counter = 0
#Get all the .json files on specified folder and use them as a parameter. Each file will correspond to a deployment.
$parameters = Get-ChildItem -Filter "*.json" -File -Path $ParametersFolder
$parametersCount = $parameters.Count

Write-Output "Found $parametersCount parameter files"

foreach ($p in $parameters)
{
    Write-Output "*** Counter: $counter Parameter: $p"

    $resourceGroupLocation = $p.Name.Split(".")[0] #Get the location from the parameter file name
    $resourceGroupName = "$resourceGroupBaseName$counter"
    $deploymentName = "$deploymentBaseName$counter"
    $logOutputFile = "$OutputFolder\$($p.BaseName)-$resourceGroupName-$deploymentName.txt"

    #Creates the resource group.
    Write-Output "`tCreating Resource Group: $resourceGroupName"
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation >> $logOutputFile

    #Deploys the template and saves the output.
    Write-Output "`tCreating Deployment: $deploymentName"
    New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateUri $MainTemplateUri -TemplateParameterFile $p.FullName >> $logOutputFile

    #Saves the log output.
    Write-Output "`tSaving deployment log: $logOutputFile"
    Get-LastDeploymentOperation -ResourceGroupName $resourceGroupName | ConvertTo-DeploymentOperationSummary >> $logOutputFile

    #Removes the resource group.
    Write-Output "`tDeleting Resource Group: $resourceGroupName"
    Remove-AzureRmResourceGroup -Name $resourceGroupName -Force >> $logOutputFile

    $counter++
}