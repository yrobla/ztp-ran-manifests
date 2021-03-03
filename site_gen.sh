#!/usr/bin/env bash

CLUSTER_NAME=$1
PROFILE=$2

if [ $PROFILE == "cu" ]; then
  cp -rf manifests/sites/sample-site-cu manifests/sites/${CLUSTER_NAME}
  sed -i "s/sample-site-cu/$CLUSTER_NAME/g" manifests/sites/${CLUSTER_NAME}/*
elif [ $PROFILE == "du" ]; then
  cp -rf manifests/sites/sample-site-du manifests/sites/${CLUSTER_NAME}
  sed -i "s/sample-site-du/$CLUSTER_NAME/g" manifests/sites/${CLUSTER_NAME}/*
elif [ $PROFILE == "cu-du" ]; then
  cp -rf manifests/sites/sample-cu-du-site manifests/sites/${CLUSTER_NAME}
  sed -i "s/cnf-cu-du-site/$CLUSTER_NAME/g" manifests/sites/${CLUSTER_NAME}/*
else
  echo "Profile should match cu, du, cu-du . Profile=" $PROFILE
  exit 0
fi

echo "  - "$CLUSTER_NAME >> ./sites/kustomization.yaml