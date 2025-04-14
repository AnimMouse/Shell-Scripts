#!/bin/sh
set -eu
app_id=$(az ad app create --display-name "$1" --sign-in-audience AzureADMyOrg --web-redirect-uris "http://localhost:53682/" --web-home-page-url "https://rclone.org/onedrive/" | jq -r .appId)
az ad app credential reset --id $app_id --display-name Rclone --years 10 > $app_id.json
az ad app permission add --id $app_id --api 00000003-0000-0000-c000-000000000000 --api-permissions 10465720-29dd-4523-a11a-6a75c743c9d9=Scope df85f4d6-205c-4ac5-a5ea-6bf408dba283=Scope 5c28f0bf-8a70-41f1-8ab2-9032436ddb65=Scope 863451e7-0667-486c-a5d6-d135439485f0=Scope 7427e0e9-2fba-42fe-b0c0-848c9e6a8182=Scope 205e70e5-aba6-4c52-a976-6d2d46c48043=Scope e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope