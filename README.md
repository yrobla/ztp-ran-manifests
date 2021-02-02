# ztp-ran-manifests
This repository contain all the manifests to configure RAN clusters that used with the ACM manifest at https://github.com/redhat-ztp/ztp-acm-manifests

# For external use with ACM manifest
- You will need to fork this repository and execute the [site_gen.sh](https://github.com/redhat-ztp/ztp-ran-manifests/blob/main/site_gen.sh) script in order to generate your cluster profile.

- The [site_gen.sh](https://github.com/redhat-ztp/ztp-ran-manifests/blob/main/site_gen.sh) script take 2 parameters with the following order to execute: 
    - Cluster_name (your cluster name)
        - Note: the cluste name should be the same as the cluster name you used with ACM manifest to create the cluster profile.
    - Profile (which profile you want to apply to your cluster. It is either cu or du)
        - Note: the cluste profile should be the same as the cluster profile you used with ACM manifest.

- After executing the site_gen.sh script you will find a directory created under the manifest/sites/{with_YOUR_CLUSTER_NAME}.

- You need to modify the complianceType/spec section in the 04_sriov_network_node_policy.yaml file under manifest/sites/{with_YOUR_CLUSTER_NAME} with the intf name and type that match your cluster nodes.

- Finally you need to upload the generated files to the ztp-ran-manifest repository you forked as we mentioned above.