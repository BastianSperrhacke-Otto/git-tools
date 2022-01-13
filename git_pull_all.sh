#!/bin/bash
rootfolder=$1
if [[ -z "$rootfolder" ]];
then
    rootfolder="./"
fi
cd $rootfolder
ignoreFolders=("\$Recycle.Bin/") #separate with space
for d in */ ; do
	[ -L "${d%/}" ] && continue
	if [[ " ${ignoreFolders[*]} " == *" $d "* ]]; then
	    echo "ignore Folder contains $d"
	else
		echo "git pull for $d"
		cd $d
		if ! git pull --rebase; then
			"git pull for $d NOT SUCCESSFUL"
			cd ..
			exit 8
		fi
		cd ..
	fi
done
exit 0