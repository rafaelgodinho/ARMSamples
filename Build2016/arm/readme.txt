- Requirements
    - Azure CLI (https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)

- Clone the repository

- Change parameters on azuredeploy.parameters.json file
    - newStorageAccountName
    - adminUsername
    - adminPassword
    - dnsNameForPublicIP
    - location (if different than West US)
    - vmSize (if different than Standard_D4_v2)

- To deploy:
    - Create a resource group (azure group create <Resource Group Name> <Location>)
    - Deploy the template (azure group deployment create --template-file azuredeploy.json --parameters-file azuredeploy.parameters.json <Resource Group Name>)

- To test:
    - Get the Public IP address (azure network public-ip list <Resource Group Name>)
    - SSH into the VM
    - Run Mongo commands
        - mongo
        - show databases