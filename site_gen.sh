#!/usr/bin/env bash

CLUSTER_NAME=$1
PROFILE=$2

if [ $PROFILE == "cu" ]; then
  cp -rf manifests/sites/sample-site-cu manifests/sites/${CLUSTER_NAME}
  sed -i "s/sample-site-cu/$CLUSTER_NAME/g" manifests/sites/${CLUSTER_NAME}/*
elif [ $PROFILE == "du" ]; then
  cp -rf manifests/sites/sample-site-du manifests/sites/${CLUSTER_NAME}
  sed -i "s/sample-site-du/$CLUSTER_NAME/g" manifests/sites/${CLUSTER_NAME}/*
else
  echo "Profile should be either cu or du. Profile=" $PROFILE
  exit 0
fi

cat << EOF > ./spoke_clusters/$CLUSTER_NAME.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $CLUSTER_NAME-cluster
---
apiVersion: cluster.open-cluster-management.io/v1
kind: ManagedCluster
metadata:
  labels:
    cloud: auto-detect
    vendor: auto-detect
    name: $CLUSTER_NAME-cluster
    profile: $PROFILE
  name: $CLUSTER_NAME-cluster
spec:
  hubAcceptsClient: true
---
apiVersion: agent.open-cluster-management.io/v1
kind: KlusterletAddonConfig
metadata:
  name: $CLUSTER_NAME-cluster
  namespace: $CLUSTER_NAME-cluster
spec:
  clusterName: $CLUSTER_NAME-cluster
  clusterNamespace: $CLUSTER_NAME-cluster
  clusterLabels:
    cloud: auto-detect
    vendor: auto-detect
  applicationManager:
    enabled: true
  policyController:
    enabled: true
  searchCollector:
    enabled: true
  certPolicyController:
    enabled: true
  iamPolicyController:
    enabled: true
  version: 2.1.0
EOF

echo "  - "$CLUSTER_NAME".yaml" >> ./spoke_clusters/kustomization.yaml

echo "still need to modify sites/"$CLUSTER_NAME"/04_sriov_network_node_policy.yaml with intf names that match your cluster info"