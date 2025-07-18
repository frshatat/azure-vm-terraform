#!/bin/bash
set -e

# Fetch the PAT securely from Azure Key Vault (using Azure CLI)
PAT=$(az keyvault secret show --vault-name ${KEYVAULT_NAME} --name ado-pat --query value -o tsv)

# Variables (replace YOUR_ORG with your Azure DevOps org URL)
ORG_URL="https://dev.azure.com/farisshatat120"
AGENT_VERSION="2.220.2"
AGENT_DIR="/home/${ADMIN_USERNAME}/vsts-agent-linux-x64-${AGENT_VERSION}"

# Download agent
cd /home/${ADMIN_USERNAME}
curl -O https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz
tar zxvf vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz
rm vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz
cd ${AGENT_DIR}

# Configure agent
./config.sh --unattended --url $ORG_URL --auth pat --token $PAT --pool Default --agent $(hostname) --acceptTeeEula

# Install & start agent service
sudo ./svc.sh install
sudo ./svc.sh start
