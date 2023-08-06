#!/usr/bin/env bash
[[ -z $DEBUGX ]] || set -x

REPO_ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

## Always call finish when scripts exits (error or success)
function finish {
  echo "END"
}
trap finish EXIT

#################################################
### DEFINE VARIABLES (WITH OPTIONAL DEFAULTS) ###
#################################################
VCSA_PASSWORD=${VCSA_PASSWORD:-}
HOMELAB_CONF_REPO=${HOMELAB_CONF_REPO:-~/Workspace/lab/homelab-conf}
PLAYBOOK=

#############################################
### Read parameters from the command line ###
#############################################
while getopts 'p:h' arg; do
  case $arg in
  p) export PLAYBOOK="$OPTARG" ;;
  \? | h) usage ;;
  esac
done

########################
### DEFINE FUNCTIONS ###
########################

## Print script usage information
function usage() {
  echo "Usage:"
  echo "Environment variables to be set:"
  echo "VCSA_PASSWORD     - The password for lab VMware vCenter Server"
  echo "HOMELAB_CONF_REPO - Location of configuration repository (default ~/Workspace/homelab-conf)"
  echo ""
  echo "Command line arguments:"
  echo "-p - The Ansible Playbook to run"
  echo "-h - Script help/usage"
}

## Validate script variables have all been correctly set
function validate() {

  [ -z "$VCSA_PASSWORD" ] && return 1
  [ -z "$PLAYBOOK" ] && return 1
  [ -z "$HOMELAB_CONF_REPO" ] && return 1

  PLAYBOOK_PATH="$REPO_ROOT/playbooks/$PLAYBOOK.yml"
  [ -f "$PLAYBOOK_PATH" ] || { echo "Error: $PLAYBOOK_PATH is not a valid path"; return 1; }

  PLAYBOOK_PARAMS_PATH="$HOMELAB_CONF_REPO/playbooks/$PLAYBOOK-params.yml"
  [ -f "$PLAYBOOK_PARAMS_PATH" ] || { echo "Error: $PLAYBOOK_PARAMS_PATH is not a valid path"; return 1; }

  return 0
}

## Main script logic
function main() {

  export ANSIBLE_CONFIG=$HOMELAB_CONF_REPO/ansible.cfg

  echo "Running Ansible Playbook: $PLAYBOOK_PATH ..."
  ansible-playbook -i $HOMELAB_CONF_REPO/hosts \
                   -e "@$HOMELAB_CONF_REPO/physical/params.yml" \
                   -e "@$PLAYBOOK_PARAMS_PATH" \
                   --extra-vars "vcsa_password=$VCSA_PASSWORD" \
                   $PLAYBOOK_PATH
}

# validate and run the script
if validate; then
  main
else
  usage
fi
