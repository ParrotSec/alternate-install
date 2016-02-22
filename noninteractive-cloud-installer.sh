#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

function core_install() {
	echo -e "deb http://euro3.archive.parrotsec.org/parrotsec stable main contrib non-free\ndeb http://archive.parrotsec.org/parrot stable-security main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# This file is empty, feel free to add here your custom APT repositories\n\n# The standard Parrot repositories are NOT here. If you want to\n# edit them, take a look into\n#                      /etc/apt/sources.list.d/parrot.list\n#                      /etc/apt/sources.list.d/debian.list\n\n\n\n# If you want to change the default parrot repositories setting\n# another localized mirror, then use the command parrot-mirror-selector\n# and see its usage message to know what mirrors are available\n\n\n\n#uncomment the following line to enable the Parrot Testing Repository\n#deb http://us.repository.frozenbox.org/parrot testing main contrib nonfree" > /etc/apt/sources.list
	wget -qO - http://archive.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	apt-get update
	apt-get -y --force-yes install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector euro6 #change it if you want another mirror, launch it without parameters to get the full list of available mirrors
	apt-get update
	apt-get -y --force-yes install parrot-core
	apt-get -y --force-yes dist-upgrade
	apt-get -y --force-yes autoremove
}

function cloud_install() {
	apt-get -y --force-yes install parrot-cloud parrot-tools-cloud
}

if [ `whoami` == "root" ]; then
	core_install
	cloud_install
else
	echo "R U Drunk? This script needs to be run as root!"
fi
