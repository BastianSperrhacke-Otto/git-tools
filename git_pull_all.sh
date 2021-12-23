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
echo "update keepass..."
cd /c/Users/bsperrha/OneDrive\ -\ Otto\ Group/Dokumente/keypass/keyverwaltung
git pull --rebase
cd /c/dev/productservices/
exit 0