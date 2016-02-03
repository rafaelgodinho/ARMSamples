#!/bin/sh
azure config mode arm
azure group create --name DynamicNumberOfDataDisks --location westus --template-file vm.json --parameters-file vm-parameters.json