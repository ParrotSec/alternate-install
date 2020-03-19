#!/bin/bash

show_menu(){
    if [ $# -eq 0 ]
    then
        NORMAL=`echo "\033[m"`
        MENU=`echo "\033[36m"` #Blue
        NUMBER=`echo "\033[33m"` #yellow
        FGRED=`echo "\033[41m"`
        RED_TEXT=`echo "\033[31m"`
        ENTER_LINE=`echo "\033[33m"`
        echo -e "${MENU}*********************************************${NORMAL}"
        echo -e "Welcome to Parrot On-Debian Installer Script"
        echo -e "\t\trev 0.2 - 2015-06-10"
        echo -e "${MENU}**${NUMBER} 1)${MENU} Install Core Only ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 2)${MENU} Install Headless Edition ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 3)${MENU} Install Security Edition ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 4)${MENU} Install Home Edition ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 5)${MENU} Install Embedded Edition ${NORMAL}"
        echo -e "${MENU}*********************************************${NORMAL}"
        echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
        read opt
    else
        case $1 in
        core)
            opt = 1
        ;;
        headless)
            opt = 2
        ;;
        security)
            opt = 3
        ;;
        home)
            opt = 4
        ;;
        embedded)
            opt = 5
        ;;
        esac
    fi
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


function core_install() {
	# Protect against HTTP vulnerabilities [https://www.debian.org/security/2016/dsa-3733], [https://www.debian.org/security/2019/dsa-4371]
	apt-get update
	apt-get -y full-upgrade
	apt-get -y install gnupg
	echo -e "deb https://mirror.parrot.sh/mirrors/parrot rolling main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "# The parrot repo is located at /etc/apt/sources.list.d/parrot.list" > /etc/apt/sources.list
	wget -qO - https://deb.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	apt-get update
	apt-get -y --force-yes -o Dpkg::Options::="--force-overwrite" install apt-parrot parrot-archive-keyring --no-install-recommends
	parrot-mirror-selector default rolling
	apt-get update
	apt -y --allow-downgrades -o Dpkg::Options::="--force-overwrite" install parrot-core
	apt -y --allow-downgrades -o Dpkg::Options::="--force-overwrite" dist-upgrade
	apt -y autoremove
}

function headless_install() {
	apt -y --allow-downgrades install parrot-pico
}

function security_install() {
	apt -y --allow-downgrades install parrot-interface parrot-interface-full parrot-tools-full
}

function home_install() {
	apt -y --allow-downgrades install parrot-interface parrot-interface-full parrot-interface
}

function embedded_install() {
	apt -y --allow-downgrades install parrot-mini
}



function init_function() {
clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        	option_picked "Installing Core";
		core_install;
		option_picked "Operation Done!";
        	exit;
        ;;

        2) clear;
		option_picked "Installing Headless Edition";
		core_install;
		headless_install;
		option_picked "Operation Done!";
		exit;
            ;;

        3) clear;
		option_picked "Installing Parrot Security OS";
		core_install;
		security_install;
		option_picked "Operation Done!";
		exit;
            ;;

	4) clear;
		option_picked "Installing Home Edition";
		core_install;
		home_install;
		option_picked "Operation Done!";
		exit;
		;;
	5) clear;
		option_picked "Installing Embedded Edition";
		core_install;
		embedded_install;
		option_picked "Operation Done!";
		exit;
	    ;;
        x)exit;
        ;;

	q)exit;
	;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
}

if [ `whoami` == "root" ]; then
	init_function;
else
	echo "R U Drunk? This script needs to be run as root!"
fi
