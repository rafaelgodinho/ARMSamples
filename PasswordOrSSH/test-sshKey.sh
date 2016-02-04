#!/bin/sh
azure config mode arm
azure group create --name PasswordOrSSH2 --location westus --template-file vm.json --parameters-file vm-parameters-sshKey.json