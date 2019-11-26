#!/bin/bash
# Sets up backpack for the current user

if [[ ! -e "backpack" || -d "backpack" ]]; then
	echo "backpack script not found."
	exit 1
fi

BP_COMMANDS=( install rm uninstall )
BP_PACKAGES=( basic extra ide )

CONF=$HOME/.bp/config

export PATH=$HOME/.bp/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.bp/lib:$LD_LIBRARY_PATH


echo "export backpack_path=$PWD" > $CONF
echo "export backpack=$PWD/backpack" >> $CONF


for c in "${BP_COMMANDS[@]}"; do
	echo "export backpack_$c=$PWD/bp-$c" >> $CONF
	for p in "${BP_PACKAGES[@]}"; do
		FNAME="bp-$c-$p"
		touch $FNAME
		chmod +x $FNAME
		echo "#!/bin/bash" > $FNAME
		echo 'source $backpack_'"$c" >> $FNAME
		echo "source pkg-$p" >> $FNAME
	done
done

echo 'source $HOME/.backpack.conf' >> $HOME/.bashrc
echo 'export PATH=$PATH:$backpack_path' >> $HOME/.bashrc
