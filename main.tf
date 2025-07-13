terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }

  required_version = ">= 1.3.0"
}
provider "azurerm" {
  features {}

  skip_provider_registration = true

}

module "network" {
  source              = "./modules/network"
  vnet_name           = "vnet-main"
  subnet_name         = "subnet-main"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "vm" {
  source                = "./modules/vm"
  vm_name               = "cf-flask-vm"
  vm_size               = "Standard_B1s"
  location              = var.location
  resource_group_name   = var.resource_group_name
  admin_username        = var.admin_username
  ssh_public_key_path   = var.ssh_public_key_path
  subnet_id             = module.network.subnet_id
}

module "keyvault" {
  source              = "./modules/keyvault"
  key_vault_name      = "cfkeyvault123"
  location            = var.location
  resource_group_name = var.resource_group_name
  secret_name         = "flask-secret"
  secret_value        = "my-app-api-key"
}

module "storage" {
  source                = "./modules/storage"
  storage_account_name  = "cfstoragedev123"  # must be globally unique
  container_name        = "tfstate"
  resource_group_name   = var.resource_group_name
  location              = var.location
  access_type           = "private"
}
