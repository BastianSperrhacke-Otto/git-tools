#!/bin/bash
rootfolder=$1
expectedBranchname=$2
if [[ -z "$rootfolder" ]];
then
    rootfolder="./"
fi

if [[ -z "$expectedBranchname" ]];
then
    expectedBranchname="master"
fi


cd $rootfolder
ignoreFolders=("\$Recycle.Bin/")
for d in */ ; do
	[ -L "${d%/}" ] && continue
	if [[ " ${ignoreFolders[*]} " == *" $d "* ]]; then
	    echo "ignore Folder contains $d"
	else
		cd $d
		currentBranchname=$(git branch --show-current)
		if [[ "$currentBranchname" != "$expectedBranchname" ]]; then
			echo "$d{$currentBranchname} has not the expectedBranchname{$expectedBranchname}."
		fi
		cd ..
	fi
done
exit 0