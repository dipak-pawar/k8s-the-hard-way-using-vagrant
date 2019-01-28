## k8s The Hard Way Using Vagrant

### Installing client tools and Generating Certificates
```bash
./scripts/install_client_tools.sh
./scripts/provision_ca_and_generate_certificates.sh
./scripts/generate_kube_config.sh
./scripts/generate_data_encryption_config_and_key.sh
```

### Setting up c1 and c2

```bash
./scripts/setup_etcd.sh
./scripts/setup_kubernetes_api_server.sh
./scripts/setup_k8s_controller_manager.sh
./scripts/setup_k8s_scheduler.sh
./scripts/setup_rbac_for_kubelet.sh
```


### Setting Up w1
```bash
./scripts/setup_w1_node.sh
```


### Setting Up W2
```bash
./scripts/setup_w2_node.sh
```
