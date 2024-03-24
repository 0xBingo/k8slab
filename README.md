# Kubernetes Setup with Ansible

This project automates the setup of a Kubernetes cluster using Ansible. It includes roles for setting up Docker, Kubernetes, and configuring one master and multiple worker nodes.

## Project Structure

```
k8s-cluster-init/
│
├── group_vars/
│ └── all.yml - Contains variables applicable across the project.
├── inventory.ini - Defines the hosts, categorized into masters and workers.
├── roles/
│ ├── common/ - Common setup tasks across all nodes.
│ ├── docker/ - Docker installation and configuration.
│ ├── kubernetes/ - Kubernetes components installation and configuration.
│ ├── master/ - Master node initialization and configuration.
│ └── user_setup/ - Setup of the Kubernetes management user.
└── site.yml - Main playbook that orchestrates the entire setup.
```

## Prerequisites

- Ansible 2.9 or newer
- SSH access to all the nodes defined in `inventory.ini`.
- The nodes are running Ubuntu 18.04 or 20.04.

## Setup

1. **Configure SSH Access**

   Ensure SSH access is set up for the `ansible_user` specified in `group_vars/all.yml` to all nodes defined in the inventory file.

2. **Update Inventory**

   Modify `inventory.ini` to reflect your infrastructure. Define `kmaster` under `[masters]` and worker nodes under `[workers]`.

3. **Set Variables**

   Review and update variables in `group_vars/all.yml` as necessary. This includes the `ansible_user`, `ansible_ssh_private_key_file`, and `k8s_admin_user`.

4. **Run the Playbook**

   Execute the following command to start the setup:

   ```bash
   ansible-playbook -i inventories/main/hosts site.yml --user $PRIVILEGIED_USER
   ```

## Roles Description

- **common:** Applies common system updates and configurations.
- **docker:** Installs Docker, used as the container runtime.
- **kubernetes:** Installs `kubeadm`, `kubectl`, and `kubelet`.
- **master:** Initializes the Kubernetes master node and sets up the admin configuration.
- **user:** Creates a non-root user (`k8s_admin_user`) for Kubernetes management.

## Customizing the Setup

- **Adding Worker Nodes:** To add more worker nodes, simply update the `[workers]` section in `inventory.ini`.
- **Changing Management User:** To change the Kubernetes management user, update `k8s_admin_user` in `group_vars/all.yml`.

## Troubleshooting

For any issues during the setup, check the output logs of each task. Ensure all nodes are reachable over SSH and the `ansible_user` has sudo privileges.

## Notes

- **Flexibility and Maintenance:** This README is a starting point. Feel free to customize it according to the specifics of your project or organization's requirements.
- **Documentation Best Practices:** Remember to regularly update the README as your project evolves, keeping the setup instructions, prerequisites, and role descriptions current.

This README template gives a clear overview of your project, making it easier for new users or contributors to get started.