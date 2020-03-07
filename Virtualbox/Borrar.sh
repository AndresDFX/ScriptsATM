#!usr/bin/env bash
VM={$1}
VBoxManage unregistervm ${VM} --delete
echo "Eliminando VM ${VM}"

