#!/bin/bash

##############################
# A script to create a cluster
##############################

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Create a KIND cluster
#
kind delete cluster 2>/dev/null
kind create cluster --config='./cluster.yaml'
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the Kubernetes cluster'
  exit 1
fi

#
# Run the load balancer
#
../utils/run-load-balancer.sh
if [ $? -ne 0 ]; then
  echo '*** Problem encountered running the load balancer'
  exit 1
fi
