# k8slab: A Homelab Kubernetes Cluster Setup

k8slab is designed to simplify the process of setting up a Kubernetes cluster in a homelab environment, leveraging Proxmox VMs for creating both master and worker nodes. This project utilizes Terraform for infrastructure provisioning and Ansible for configuration management, ensuring that your Kubernetes nodes are ready to go with minimal manual intervention.

## Project Structure

```plaintext
.
├── bootstrap.yml                # Initial bootstrap playbook
├── cloud-init                   # Cloud-init configurations for VMs
│   ├── metadata.yml             # VM metadata
│   └── userdata.yml             # User data for VM customization
├── group_vars
│   └── all.yml                  # Ansible variables applicable to all hosts
├── inventories
│   └── main
│       └── hosts                # Ansible inventory file
├── main.tf                      # Terraform configuration for VM provisioning
├── provider.tf                  # Terraform provider configuration
├── README.md                    # This documentation
├── roles                        # Ansible roles for various configurations
│   ├── common
│   ├── docker
│   ├── kubernetes
│   ├── master
│   ├── ssh
│   └── terraform
├── site.yml                     # Main Ansible playbook
├── terraform.tfvars             # Terraform variables
└── variables.tf                 # Terraform variable definitions
```

## Features

- **Automated Kubernetes Cluster Setup**: Quickly provision a fully-functional Kubernetes cluster.
- **Cloud-Init Integration**: Leverages cloud-init for VM customization and initial setup.
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
   ansible-playbook bootstrap.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts -e group_vars/secrets.yml --vault-id [YOUR-VAULT-ID-PATH]
   ```
   Note: I am using a `secrets.yml` to prevent leaking my `vm_password`.


2. **Configure Terraform**: 

   Run this command to get the Terraform token and update the `api_token` inside `variables.tf`:
   ```
   pveum user token add terraform@pve terraform -expire 0 -privsep 0 -comment "Terraform token"
   ```

   We need to open a SSH agent to connect to the cluster :
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
