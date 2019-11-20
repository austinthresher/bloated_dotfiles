#!/bin/bash
# Sets up backpack for the current user

if [[ ! -e "backpack" || -d "backpack" ]]; then
	echo "backpack script not found."
	exit 1
fi

BP_COMMANDS=( install rm uninstall )
BP_PACKAGES=( core extra x11 )

CONF=$HOME/.backpack.conf

echo "export BACKPACK_PATH=$PWD" > $CONF
echo "export BACKPACK=$PWD/backpack" >> $CONF

for c in "${BP_COMMANDS[@]}"; do
	echo "export BACKPACK_${c^^}=$PWD/bp-$c" >> $CONF
	for p in "${BP_PACKAGES[@]}"; do
		FNAME="bp-$c-$p"
		touch $FNAME
		chmod +x $FNAME
		echo "#!/bin/bash" > $FNAME
		echo 'source $BACKPACK_'"${c^^}" >> $FNAME
		echo "source pkg-$p" >> $FNAME
	done
done

echo 'source $HOME/.backpack.conf' >> $HOME/.bashrc
echo 'export PATH=$PATH:$BACKPACK_PATH' >> $HOME/.bashrc
