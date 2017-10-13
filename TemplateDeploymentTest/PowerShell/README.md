# About

Script to facilite Azure Resource Manager templates stress test. Useful for Microsoft ISV partners deploying solution template offers on the Azure Marketplace.

# Prerequisites

 - Azure PowerShell cmdlets installed and configured to access your Azure Subscription.
    - More details [here](https://docs.microsoft.com/en-us/powershell/azure/overview?view=azurermps-4.4.0).
 - Parameter files for the ARM template located on a single folder
    - The parameter files must have the following naming convention: *\<Azure Region>.\<Name>.json*
        - The Azure Region in the file name will be used on the resource group creation.
    - Each parameter file will be deployed once. So, if you need to execute 10 tests, you will need 10 different parameter files.

# Usage

Use the following syntax to execute the script:

```
testScript.ps1 -MainTemplateUri <uri> -ParametersFolder <path> -OutputFolder <path>
```

Example:
```
testScript.ps1 -MainTemplateUri https://raw.githubusercontent.com/rafaelgodinho/ARMSamples/master/VirtualNetworkNewOrExisting/network.json -ParametersFolder .\parameters -OutputFolder .\output
```

# Output

For each parameter file the deployment log will be save on the *OutputFolder* location. The log file will have the following naming convention: *\<Parameter File>-\<Resource Group Name>-\<Deployment Name>.txt*.