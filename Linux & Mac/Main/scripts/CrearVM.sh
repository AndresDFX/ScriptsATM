#!/usr/bin/env bash
VM=${1}
mem=1024
cpu=2
echo "Creando maquina virtual en Linux ${VMNAME}"
VBoxManage createhd --filename ${VM}.vdi --size 3276MB
VBoxManage createvm --name $VM --ostype "Ubuntu_64" --register
VBoxManage modifyvm ${VM} --memory 1024
VBoxManage modifyvm ${VM} --cpus 1
