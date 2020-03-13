#!/usr/bin/env bash

VM={$1}
VBoxManage unregistervm ${VM} --delete
echo "Eliminando VM ${VM}"

if [ $? -eq 0 ]; then
	echo "End"
	exit 0
else 
	echo "Error al borrar ${VM}"
	exit 1
fi

