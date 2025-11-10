# Préparation Environnement Azure

## Resource Group
- RG: rg-hybrid-infra
- Créé dans le portail Azure ou via CLI

## Storage Account
- Storage: tfstatehybrid
- Container: tfstate
- Soft delete activé

## Terraform Backend
- Configurer backend dans main.tf avec storage account et container ci-dessus

## Notes
- Vérifier l’accès portail et Cloud Shell
- Vérifier rôle Contributor
