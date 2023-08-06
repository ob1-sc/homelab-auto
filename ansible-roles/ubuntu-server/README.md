Ubuntu Server
=========

Ansible role that can be used to deploy an Ubuntu Server OVA on a running VMware vCenter Server.

Requirements
------------

- Tested on Ansible 2.15.2
- Requires `community.vmware` Ansible Galaxy Collection

Role Variables
--------------

All variables which can be overridden are stored in defaults/main.yml file as well as in table below.

| Variable                      | Default                                          | Description                                                                   |
|-------------------------------|--------------------------------------------------|-------------------------------------------------------------------------------|
| temp_dir                      | /tmp                                             | Temp dir to store Ubuntu OVA                                                  |
| ubuntu_ova_url_base           | https: //cloud-images.ubuntu.com/jammy/current/  | Location to download Ubuntu OVA from                                          |
| ubuntu_ova                    | jammy-server-cloudimg-amd64.ova                  | Name of the OVA file to download from the `ubuntu_ova_url_base` location      |
| vcsa_hostname                 | ""                                               | URL or IP address of the vCenter server to deploy the OVA to                  |
| vcsa_username                 | ""                                               | User name to access the vCenter server                                        |
| vcsa_password                 | ""                                               | Password to access the vCenter server                                         |
| datacenter                    | ""                                               | The datacenter to deploy the Ubuntu OVA into in the vCenter Inventory         |
| cluster                       | ""                                               | The cluster to deploy the Ubuntu OVA into in the vCenter Inventory            |
| datastore                     | ""                                               | The datastore to store the Ubuntu OVA into in the vCenter Inventory           |
| ubuntu_vm_name                | ""                                               | The name of the VM as it will appear in the vCenter Inventory                 |
| ubuntu_vm_network             | ""                                               | The port group to attach the Ubuntu VM to                                     |
| ubuntu_vm_memory              | 4096                                             | The amount of memory to assign to the Ubuntu VM                               |
| ubuntu_vm_cpus                | 4                                                | The number of CPU's to assign to the Ubuntu VM                                | 
| ubuntu_vm_disk_size           | 500                                              | The ammount of disk storage to assign to the Ubuntu VM                        |
| ubuntu_client_hostname        | ""                                               | The hostname to set inside the Ubuntu VM                                      |
| ubuntu_client_ns_search_path  | ""                                               | The DNS search path to try when translating a machine name into an IP address |
| ubuntu_client_ip_address      | ""                                               | The static ip address to assign to the Ubuntu VM                              |
| ubuntu_client_gateway         | ""                                               | The gateway ip address of the network the Ubuntu VM is attached to            |
| ubuntu_client_nameserver      | ""                                               | The DNS server that will be used for DNS lookups within the Ubuntu VM         | 
| ubuntu_client_ssh_key         | ""                                               | A public SSH key to assign to the VM to allow for SSH access                  |
| ubuntu_client_username        | "ubunut"                                         | The name of the main user on the VM                                           |

Example Playbook
----------------

```
---
- name:  Deploy Ubuntu server VM
  hosts: localhost
  gather_facts: false
  vars:
    temp_dir           : "/tmp"
    ubuntu_ova         : "jammy-server-cloudimg-amd64.ova"
    ubuntu_ova_url_base: "https://cloud-images.ubuntu.com/jammy/current/"

    vcsa_hostname: "vcenter.acme.local"
    vcsa_username: "administrator@acme.local"
    vcsa_password: "supersecurepassword:p"
    datacenter   : "acmedc"
    cluster      : "acmecluster"
    datastore    : "acmeds"

    ubuntu_vm_name     : "coolubuntuvm"
    ubuntu_vm_network  : "portgroupname"
    ubuntu_vm_memory   : "4096"
    ubuntu_vm_cpus     : "4"
    ubuntu_vm_disk_size: "500"

    ubuntu_client_hostname      : "ubuntuserver"
    ubuntu_client_ns_search_path: "acme.local"
    ubuntu_client_ip_address    : "192.168.1.99/24"
    ubuntu_client_gateway       : "192.168.1.1"
    ubuntu_client_nameserver    : "192.168.1.1"
    ubuntu_client_ssh_key       : "ssh-rsa AAAAB3NzaC1yc2......etcetc" 
    ubuntu_client_username      : "ubuntu" 

  roles:
  - ubuntu-server
```

License
-------

See license.md

Author Information
------------------
Simon O'Brien