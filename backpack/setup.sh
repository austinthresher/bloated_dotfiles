#!/bin/bash
# Sets up backpack for the current user

if [[ ! -e "backpack" || -d "backpack" ]]; then
	echo "backpack script not found."
	exit 1
fi

backpack_root=$HOME/.bp
backpack_scripts=$backpack_root/scripts
backpack_bin=$backpack_root/bin
backpack_lib=$backpack_root/lib
backpack_config=$backpack_root/config

mkdir -p $backpack_root
mkdir -p $backpack_scripts
mkdir -p $backpack_bin
mkdir -p $backpack_lib

rm -f $backpack_scripts/*
cp ./packages $backpack_scripts/
cp ./backpack $backpack_scripts/
cp ./*.sed    $backpack_scripts/
chmod +x $backpack_scripts/backpack

echo "export backpack_root=$backpack_root" > $backpack_config
cat >> $backpack_config << 'EOF'
export backpack_bin=$backpack_root/bin
export backpack_lib=$backpack_root/lib
export backpack_scripts=$backpack_root/scripts
export backpack=$backpack_scripts/backpack
export PATH=$backpack_bin:$backpack_scripts:$PATH
export LD_LIBRARY_PATH=$backpack_lib:$LD_LIBRARY_PATH
EOF
