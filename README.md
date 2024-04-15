# k8slab: A Homelab Kubernetes Cluster Setup

k8slab is designed to simplify the process of setting up a Kubernetes cluster in a homelab environment, leveraging Proxmox VMs for creating both master and worker nodes. This project utilizes Terraform for infrastructure provisioning and Ansible for configuration management, ensuring that your Kubernetes nodes are ready to go with minimal manual intervention.

![Project Screenshot](images/k8slab.png)

## Project Structure

```plaintext
.
├── bootstrap.yml                # Initial bootstrap playbook
├── group_vars
│   └── all.yml                  # Ansible variables applicable to all hosts
├── inventories
│   └── main
│       └── hosts                # Ansible inventory file
├── local-kubeconfig.yml         # Ansible kube config local setup
├── main.tf                      # Terraform configuration for VM provisioning
├── provider.tf                  # Terraform provider configuration
├── node.tf                      # Terraform provider configuration
├── terraform.tfvars             # Terraform variables values
├── README.md                    # This documentation
├── roles                        # Ansible roles for various configurations
│   ├── common
│   ├── docker
│   ├── master
│   ├── proxmox
│   ├── terraform
│   └── worker
├── site.yml                     # Main Ansible playbook
├── credentials.auto.tfvars      # Terraform secrets variables (not commited)
├── terraform.tfvars             # Terraform variables
└── variables.tf                 # Terraform variable definitions
```

## Features

- **Automated Kubernetes Cluster Setup**: Quickly provision a fully-functional Kubernetes cluster.
- **Docker and Kubernetes Configuration**: Ansible roles included for Docker setup and Kubernetes cluster initialization.
- **SSH Configuration**: Automated SSH setup for secure communication.

## Requirements

- **Proxmox VE**: A working Proxmox VE environment for VM provisioning.
- **Terraform**: For automated infrastructure provisioning.
- **Ansible**: For configuration management and automation.

## Getting Started

1. **Prepare Your Proxmox Environment**:

   To create the nodes, you will need to create the Terraform token of the proxmox by running the bootstrap to configure the role
   ```
   ansible-playbook bootstrap.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts --vault-id [YOUR-VAULT-ID-PATH]
   ```

2. **Configure Terraform**: 

   After running the bootstrap, create a file named `credentials.auto.tfvars` with the template below, then update the `proxmox_api_token_secret` :
   ```
   proxmox_api_url = "https://192.168.1.1:8006/api2/json"  # Your Proxmox IP Address
   proxmox_api_token_id = "terraform@pve!terraform"  # API Token ID
   proxmox_api_token_secret = "" # API Token Secret
   ```

   We next need to open a SSH agent to connect to the cluster using our private key :
   ```
   eval $(ssh-agent)
   ssh-add ~/.ssh/id_rsa
   ```

   You can finally create your nodes using :
   ```
   terraform init
   terraform apply
   ```

3. **Configure VMs with Ansible**:

   - Update the Ansible inventory in `inventories/main/hosts` with the IP addresses of your new VMs.
   - Run the Ansible playbook:
    ```bash
    ansible-playbook site.yml -i inventories/main/hosts 
    ```
