#!/bin/bash

SPECFILE="jenkins-plugins.spec"
REPONAME=`awk '/^Name:/ {print $2}' $SPECFILE`
VERSION="stable-`awk '/^Version/ {print $2}' $SPECFILE`"
UPDATE_CENTER="http://updates.jenkins-ci.org/$VERSION/latest/"

rm -rfv index.html plugins.list $REPONAME
mkdir -p $REPONAME
wget $UPDATE_CENTER -O index.html

if [ $? -ne 0 ]; then
	echo "Failed to get plugin list"
	exit 1
fi

if [ "$(grep "href=.*\.hpi" index.html | wc -l) -gt 0" ]; then
	grep -Po "(?<=href=')[^(.hpi)]+.hpi" index.html > plugins.list
	rm -f index.html
else
	exit 1
fi

while read PLUGIN
do
	echo
	echo "$PLUGIN"
	if ! wget "$UPDATE_CENTER$PLUGIN" -O $REPONAME/$PLUGIN ; then
		echo "Failed to download $PLUGIN"
		exit 1
	fi
done < plugins.list

zip -r $REPONAME.zip $REPONAME
