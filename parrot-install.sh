#!/bin/bash

show_menu(){
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
    echo -e "${MENU}**${NUMBER} 2)${MENU} Install Cloud Edition ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Install Standard Edition ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Install Full Edition ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Install Home Edition ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Install Embedded Edition ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


function core_install() {
	echo -e "deb http://eu.repository.frozenbox.org/mirrors/parrot stable main contrib non-free" > /etc/apt/sources.list.d/parrot.list
	echo -e "deb http://eu.repository.frozenbox.org/mirrors/debian jessie main contrib non-free\n#deb-src http://eu.repository.frozenbox.org/mirrors/debian jessie main contrib non-free\n\n#deb http://eu.repository.frozenbox.org/mirrors/debian jessie-backports main contrib non-free\n#deb-src http://eu.repository.frozenbox.org/mirrors/debian jessie-backports main contrib non-free\n\ndeb http://security.debian.org/ jessie/updates main\n#deb-src http://security.debian.org/ jessie/updates main\n\ndeb http://eu.repository.frozenbox.org/mirrors/debian jessie-updates main contrib non-free\n#deb-src http://eu.repository.frozenbox.org/mirrors/debian jessie-updates main contrib non-free\n\n#deb http://eu.repository.frozenbox.org/mirrors/debian jessie-proposed-updates main contrib non-free\n#deb-src http://eu.repository.frozenbox.org/mirrors/debian jessie-updates main contrib non-free" > /etc/apt/sources.list.d/debian.list
	apt-get update
	apt-get -y dist-upgrade
	apt-get update
	apt-get -y install apt-parrot parrot-archive-keyring --no-install-recommends
	apt-get update
	apt-get -y install parrot-core
	apt-get -y dist-upgrade
}

function cloud_install() {
	apt-get -y install parrot-cloud parrot-tools-cloud
}

function standard_install() {
	apt-get -y install parrot-interface parrot-tools
}

function full_install() {
	apt-get -y install parrot-interface parrot-tools parrot-interface-full parrot-tools-full
}

function home_install() {
	apt-get -y install parrot-interface parrot-interface-full
}

function embedded_install() {
	apt-get -y install parrot-interface parrot-tools-arm
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
		option_picked "Installing Cloud Edition";
		core_install;
		cloud_install;
		option_picked "Operation Done!";
		exit;
            ;;

        3) clear;
		option_picked "Installing Parrot Security OS";
		core_install;
		standard_install;
		option_picked "Operation Done!";
		exit;
            ;;

        4) clear;
		option_picked "Installing Full Edition";
		core_install;
		full_install;
		option_picked "Operation Done!";
		exit;
            ;;
	5) clear;
		option_picked "Installing Home Edition";
		core_install;
		home_install;
		option_picked "Operation Done!";
		exit;
		;;
	6) clear;
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
