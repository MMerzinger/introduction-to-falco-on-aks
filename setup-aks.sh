#!/bin/bash

export REGION='northeurope'
export RG_NAME="rg-aks-falco-${RANDOM:0:2}"
export AKS_NAME="aks-falco-${RANDOM:0:2}"
export LA_WORKSPACE_NAME="la-aks-falco-${RANDOM:0:2}"

az group create -n $RG_NAME -l $REGION

az monitor log-analytics workspace create -n $LA_WORKSPACE_NAME -g $RG_NAME -l $REGION

LA_ID=$(az monitor log-analytics workspace show -n $LA_WORKSPACE_NAME -g $RG_NAME -o tsv --query id)

az aks create -n $AKS_NAME -l $REGION -g $RG_NAME --kubernetes-version 1.19.9 --enable-managed-identity --enable-addons monitoring --workspace-resource-id $LA_ID

az aks get-credentials -n $AKS_NAME -g $RG_NAME

#az group delete -n $RG_NAME --yes
