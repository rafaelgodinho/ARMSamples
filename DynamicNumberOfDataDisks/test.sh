#!/bin/sh
azure config mode arm
azure group create --name DynamicNumberOfDataDisks --location westus --template-file mainTemplate.json --parameters-file mainTemplate-parameters.json