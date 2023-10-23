#!/bin/bash
rootfolder=$1
if [[ -z "$rootfolder" ]];
then
    rootfolder="./"
fi
cd $rootfolder
ignoreFolders=("\$Recycle.Bin/")
for d in */ ; do
	[ -L "${d%/}" ] && continue
	if [[ " ${ignoreFolders[*]} " == *" $d "* ]]; then
	    echo "ignore Folder contains $d"
	else
		echo "git pull for $d"
		cd $d
		currentBranch=$(git branch --show-current)
		if [[ "$currentBranch" == "master" ]]; then
		  echo "current branch is $currentBranch"
    else
      echo "`tput setaf 1`current branch is not master, it is $currentBranch"
		fi
		if ! git pull --rebase; then
			echo "`tput setaf 1`==========================================="
			echo "`tput setaf 1`==========git pull for $d NOT SUCCESSFUL================"
			echo "`tput setaf 1`==========================================="
			#exit 8
		fi
		git submodule foreach git pull origin master || true
		cd ..
	fi
done
exit 0