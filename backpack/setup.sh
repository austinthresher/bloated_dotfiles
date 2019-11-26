#!/bin/bash
# Sets up backpack for the current user

if [[ ! -e "backpack" || -d "backpack" ]]; then
	echo "backpack script not found."
	exit 1
fi

bp_commands=( install rm uninstall )
bp_packages=( basic extra ide )

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
cp ./backpack $backpack_scripts/
for c in "${bp_commands[@]}"; do cp bp-$c $backpack_scripts/; done
for p in "${bp_packages[@]}"; do cp pkg-$p $backpack_scripts/; done

echo "export backpack_root=$backpack_root" > $backpack_config

cat >> $backpack_config << 'EOF'
export backpack_bin=$backpack_root/bin
export backpack_lib=$backpack_root/lib
export backpack_scripts=$backpack_root/scripts
export backpack=$backpack_scripts/backpack
export PATH=$backpack_bin:$backpack_scripts:$PATH
export LD_LIBRARY_PATH=$backpack_lib:%s
EOF

for c in "${bp_commands[@]}"; do
	printf "export backpack_$c=%s/bp-$c\n" '$backpack_scripts' >> $backpack_config
	for p in "${bp_packages[@]}"; do
		FNAME="$backpack_scripts/bp-$c-$p"
		touch $FNAME
		chmod +x $FNAME
		echo "#!/bin/bash" >> $FNAME
		echo -n 'source $backpack_' >> $FNAME
		echo "$c" >> $FNAME
		echo -n 'source $backpack_scripts/pkg-' >> $FNAME
		echo "$p" >> $FNAME
	done
done
