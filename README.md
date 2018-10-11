# ansible-kubernetes
Using Ansible to bootstrap Kubernetes on Ubuntu Proxmox VMs.

## TLDR;

```
# Step 1
# Prepare Ubuntu 18.04 LTS VMs on Proxmox.
# One for master and several for workers. Use same username.
# Take snapshot after installation completes

# Step 2
cd playbook
chmod +x ./copy_ssh.sh
./copy_ssh.sh <vm_username> <vm1_ip> <vm2_ip> ...

# Step 3
# Consult host.ini.example and create host.ini

# Step 4
ansible-playbook playbook.yaml
```

After installation, check out `/tmp/admin.conf` on the controller system for kubernetes configuration file.

## What it does

This playbook bootstraps a single master kubernetes cluster on a set of Ubuntu 18.04 LTS VMs. For a more complete installation tool, one should look to [kubespray](http://kubespray.io). I created this playbook mainly to limit the unneeded configuration options.

VMs do not have to be provided by Proxmox, but mine were. Technically, the VM creation process can also be automated as Proxmox does provide [API](https://pve.proxmox.com/wiki/Proxmox_VE_API), but that is another job another day.

For the most part, this playbook follows instructions on [the offical site](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/). It also supports passing custom startup parameters to `kubeadm` and modification of the networking configuration YAML files with [yq](http://mikefarah.github.io/yq/).

Ansible does not have a particular nice solution for passing variables between plays on different hosts. In this case, it is needed to pass the kubeadm token and master CA certification hash to the worker hosts. This playbook does this by writing them to files and download them to the controller host before re-uploading them to the work hosts. These secrets are **NOT removed** after the playbook completes so users can easily reuse them to join other manually bootstraped hosts.

## Develop

```
vagrant up
cd playbook
ansible-playbook playbook.yaml
```
