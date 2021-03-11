#!/usr/bin/env bash

CLUSTER_NAME=$1
PROFILE=$2
TARGET_DIR=${3:-./manifests/sites}

# This script creates the site from a template. No support for
# modifying an existing set of manifests so simply fail with an error
# message if the cluster manifest directory already exists
if [ -e ${TARGET_DIR}/${CLUSTER_NAME} ] ; then
    echo "Cluster manifests directory already exists: ${TARGET_DIR}/${CLUSTER_NAME}"
    exit 1
fi

# Ensure the destination directory exists and create it if not.
if [ ! -d ${TARGET_DIR} ] ; then
    mkdir -p ${TARGET_DIR}
    if [ $? -ne 0 ] ; then
	echo "Failed to create target dir"
	exit 1
    fi
fi


if [ $PROFILE == "cu" ]; then
  cp -rf manifests/sites/sample-site-cu ${TARGET_DIR}/${CLUSTER_NAME}
  sed -i "s/sample-site-cu/$CLUSTER_NAME/g" ${TARGET_DIR}/${CLUSTER_NAME}/*
elif [ $PROFILE == "du" ]; then
  cp -rf manifests/sites/sample-site-du ${TARGET_DIR}/${CLUSTER_NAME}
  sed -i "s/sample-site-du/$CLUSTER_NAME/g" ${TARGET_DIR}/${CLUSTER_NAME}/*
elif [ $PROFILE == "cu-du" ]; then
  cp -rf manifests/sites/sample-cu-du-site ${TARGET_DIR}/${CLUSTER_NAME}
  sed -i "s/cnf-cu-du-site/$CLUSTER_NAME/g" ${TARGET_DIR}/${CLUSTER_NAME}/*
else
  echo "Profile should match cu, du, cu-du . Profile=" $PROFILE
  exit 0
fi

kustom="${TARGET_DIR}/kustomization.yaml"
# Copy over the baseline kustomization.yaml if one does not already
# exist but strip out the example sites.
if [ ! -s ${kustom} ] ; then
    cp -a manifests/sites/kustomization.yaml ${TARGET_DIR}/
    sed -i '/^.*sample-site-[cd]u.*$/d' ${TARGET_DIR}/kustomization.yaml
    sed -i '/^.*cnf-cu-du-site.*$/d' ${TARGET_DIR}/kustomization.yaml
fi

# Ensure a newline exists on last line in kustomization
last_byte=$( tail -c 1 ${kustom} | xxd -ps )
if [ ${last_byte:-error} != "0a" ] ; then
    echo "" >> ${kustom}
fi
echo "  - "$CLUSTER_NAME >> ${kustom}
