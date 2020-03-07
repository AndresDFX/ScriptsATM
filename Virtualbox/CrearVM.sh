#!/usr/bin/env bash

#Este es un script para crear una maquina virtual


VM=${1}
mem=1024
cpu=2
echo "Creando maquina virtual en Linux ${VMNAME}"

if [-z $VM]; then
	VM="default"
else
	source Borra.sh ${VM}

fi

VBoxManage createhd --filename ${VM}.vdi --size 3276MB
VBoxManage createvm --name $VM --ostype "Ubuntu_64" --register
VBoxManage modifyvm ${VM} --memory ${mem}
VBoxManage modifyvm ${VM} --cpus ${cpu}
