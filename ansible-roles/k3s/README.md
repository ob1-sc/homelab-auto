K3s Server
=========

Ansible role that can be used to deploy k3s onto a running server.

Requirements
------------

- Tested on Ansible 2.15.2

Role Variables
--------------

All variables which can be overridden are stored in defaults/main.yml file as well as in table below.

| Variable                      | Default                                          | Description                                                                   |
|-------------------------------|--------------------------------------------------|-------------------------------------------------------------------------------|
| k3s_server_hostname           | ""                                               | Host name of the k3s to be populated in generated kubeconfig                  |
| local_kubeconfig              | "~/.kube/config"                                 | Location on client to download kubeconfig to                                  |

Example Playbook
----------------

```
- name:  Setup k3s server
  hosts: k3s
  become: true
  vars:
    local_user: "fred"

  pre_tasks:
  - name: upgrade apt repositories
    apt:
      update_cache: true

  roles:
  - k3s

  post_tasks:
  - name: cleanup apt packages
    apt:
      autoclean: true
      autoremove: true
```

License
-------

See license.md

Author Information
------------------
Simon O'Brien