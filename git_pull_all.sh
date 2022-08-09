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
		echo "current branch is $(git branch --show-current)"
		if ! git pull --rebase; then
			echo "==========================================="
			echo "==========git pull for $d NOT SUCCESSFUL================"
			echo "==========================================="
			#exit 8
		fi
		git submodule foreach git pull origin master || true
		cd ..
	fi
done
exit 0