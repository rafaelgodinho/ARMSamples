#!/bin/sh
azure config mode arm
azure group create --name PasswordOrSSH1 --location westus --template-file vm.json --parameters-file vm-parameters-password.json