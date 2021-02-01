#!/usr/bin/env bash

CLUSTER_NAME=$1
profile=$2

if [ $profile == "cu" ]; then
  cp -rf sites/sample-site-cu sites/${CLUSTER_NAME}
  sed -i "s/sample-site-cu/$CLUSTER_NAME/g" sites/${CLUSTER_NAME}/*
elif [ $profile == "du" ]; then
  cp -rf sites/sample-site-du sites/${CLUSTER_NAME}
  sed -i "s/sample-site-du/$CLUSTER_NAME/g" sites/${CLUSTER_NAME}/*
else
  echo "Profile should be either cu or du. Profile=" $profile
fi

# still need to modify 04_sriov_network_node_policy.yaml with intf names