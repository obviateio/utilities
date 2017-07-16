#!/bin/bash

if [ -z "$2" ]; then
	echo "Usage: mirror.sh FROM-GIT-URL TO-GIT-URL"
else
	FROM=$1
	DIR=$(echo $1 | sed 's:.*/::')
	GOTO=$2


	echo Mirroring from URL: $FROM
	echo Mirroring to URL: $GOTO
	echo Using dir: /tmp/$DIR

	read -p "Are you sure? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
		then
		cd /tmp
		git clone --mirror $FROM
		cd ./$DIR
		git remote set-url --push origin $GOTO
		git fetch -p origin
		git push --mirror
		cd ..
		rm -rf ./$DIR
	fi
fi
