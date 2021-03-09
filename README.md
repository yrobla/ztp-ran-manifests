# ztp-ran-manifests
The purpose of this repository is to contain all the RAN manifests that is used with the ACM manifest at https://github.com/redhat-ztp/ztp-acm-manifests

# For external use with ACM manifest
- You will need to fork this repository and execute the [site_gen.sh](https://github.com/redhat-ztp/ztp-ran-manifests/blob/main/site_gen.sh) script in order to generate your cluster profile.

- The [site_gen.sh](https://github.com/redhat-ztp/ztp-ran-manifests/blob/main/site_gen.sh) script takes 2 parameters with the following order: 
    - Cluster_name (your cluster name)
    - Profile (which profile you want to include in your cluster: cu, du, cu-du )

- After executing the site_gen.sh script a directory will be created under the manifest/sites/{with_YOUR_CLUSTER_NAME}.

- The CU and DU worker nodes will be labeled as [worker-cu, worker-du] based on the worker node name prefix [cnfcu, cnfdu]. Check 01_node_autolabeler_policy.yaml file for more info.

- Change the SR-IOV config in 04_sriov_network_node_policy.yaml AND 07_sriov_network_policy.yaml under the new site directory to match your worker nodes configurations.

- Finally upload the generated files to the forked ztp-ran-manifest repository as we mentioned above.