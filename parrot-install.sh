#!/bin/bash

# Parrot OS Alternative Install - All copyrights (©) are owned by: Lorenzo "Palinuro" Faletra
# Credits: @kyb3rvizsla (Kyb3r Vizsla <kyb3rvizsla.com>)

#---------- Varibles ----------
# Colours
endColor="\e[0m\e[0m"
redColor="\e[0;31m\e[1m"
blueColor="\e[0;34m\e[1m"
cyanColor="\e[01;96m\e[1m"
grayColor="\e[0;37m\e[1m"
greenColor="\e[0;32m\e[1m"
purpleColor="\e[0;35m\e[1m"
yellowColor="\e[0;33m\e[1m"
turquoiseColor="\e[0;36m\e[1m"

dot="${redColor}[${endColor}${yellowColor}*${endColor}${redColor}] ${endColor}"

# CTRL + C
trap ctrl_c INT

function ctrl_c() {
    echo -e "\n\n${dot}${yellowColor}Exiting...${endColor}"
    exit
}

# Prompt
prompt=$(echo -e "${redColor}\n┌─[root${endColor}${yellowColor}@${endColor}${cyanColor}parrot${endColor}${redColor}]-[${endColor}${greenColor}/parrot-installer${endColor}${redColor}]\n└──╼ ${endColor}")

#---------- Install Functions ----------

function core_install() {
	apt update
	apt install -y bash wget gnupg
	wget -qO - https://deb.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	cp config/etc/apt/sources.list /etc/apt/sources.list
	cp -r config/etc/apt/sources.list.d/* /etc/apt/sources.list.d
	cp config/etc/apt/sources.list.parrot /etc/apt/sources.list.parrot
	cp config/etc/apt/listchanges.conf /etc/apt/listchanges.conf
	apt update
	cp config/etc/os-release /etc/os-release
	apt -y dist-upgrade
	apt -y autoremove
	apt update
	apt install -y parrot-core
}

function headless_install() {
	apt -y --allow-downgrades install parrot-pico
}

function security_install() {
	apt --allow-downgrades install -y parrot-interface parrot-interface-full parrot-mate parrot-tools-full parrot-drivers parrot-crypto parrot-privacy parrot-devel firefox
}

function home_install() {
	apt --allow-downgrades install -y parrot-interface parrot-interface-full parrot-mate parrot-drivers parrot-privacy firefox vscodium zeal
}

function embedded_install() {
	apt -y --allow-downgrades install parrot-interface parrot-mini
}

function repos_install() {
	apt update
	apt install -y bash gnupg
	wget -qO - https://deb.parrotsec.org/parrot/misc/parrotsec.gpg | apt-key add -
	cp -r config/etc/apt/sources.list.d/* /etc/apt/sources.list.d
	apt update
}

#---------- Script Functions ----------
function menu() {
	clear
    echo -e "${blueColor} ______                              _____                      _ _       _                _            ${endColor}"
    echo -e "${blueColor}(_____ \                     _      (_____)           _        | | |     | |              (_)      _    ${endColor}"
    echo -e "${blueColor} _____) )___  ____ ____ ___ | |_       _   ____   ___| |_  ____| | |      \ \   ____  ____ _ ____ | |_  ${endColor}"
    echo -e "${blueColor}|  ____/ _  |/ ___) ___) _ \|  _)     | | |  _ \ /___)  _)/ _  | | |       \ \ / ___)/ ___) |  _ \|  _) ${endColor}"
    echo -e "${blueColor}| |   ( ( | | |  | |  | |_| | |__    _| |_| | | |___ | |_( ( | | | |   _____) | (___| |   | | | | | |__ ${endColor}"
    echo -e "${blueColor}|_|    \_||_|_|  |_|   \___/ \___)  (_____)_| |_(___/ \___)_||_|_|_|  (______/ \____)_|   |_| ||_/ \___)${endColor}"
    echo -e "${blueColor}                                                                                            |_|         ${endColor}"
	echo -e "\n${yellowColor}1) ${endColor}${blueColor}Install Core Only${endColor}"
	echo -e "${yellowColor}2) ${endColor}${blueColor}Install Headless Editions${endColor}"
	echo -e "${yellowColor}3) ${endColor}${blueColor}Install Security Edition${endColor}"
	echo -e "${yellowColor}4) ${endColor}${blueColor}Install Home Edition${endColor}"
	echo -e "${yellowColor}5) ${endColor}${blueColor}Install Embedded Edition${endColor}"
	echo -e "${yellowColor}6) ${endColor}${blueColor}Install Repositories${endColor}"

	if [ "$error" == "0" ]; then
	echo -e "\n\n${dot}${yellowColor}Option does not exist, retry${endColor}";
	fi;

	read -p "$prompt" option
}

function init_installer() {
	menu
	case $option in
		1) clear;
		echo -e "${blueColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╔═╗┌─┐┬─┐┌─┐${endColor}";
		echo -e "${blueColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ║  │ │├┬┘├┤ ${endColor}";
		echo -e "${blueColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╚═╝└─┘┴└─└─┘${endColor}${yellowColor}ooo${endColor}";
		core_install
		echo -e "\n\n${dot}${yellowColor}Parrot OS Core Installed!!!${endColor}"
		;;

		2) clear;
		echo -e "${purpleColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╦ ╦┌─┐┌─┐┌┬┐┬  ┌─┐┌─┐┌─┐${endColor}"
		echo -e "${purpleColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ╠═╣├┤ ├─┤ │││  ├┤ └─┐└─┐${endColor}"
		echo -e "${purpleColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╩ ╩└─┘┴ ┴─┴┘┴─┘└─┘└─┘└─┘${endColor}${yellowColor}ooo${endColor}"
		core_install;
		headless_install;
		echo -e "\n\n${dot}${yellowColor}Parrot OS Headless Installed!!!${endColor}"
		;;

		3) clear;
		echo -e "${redColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╔═╗┌─┐┌─┐┬ ┬┬─┐┬┌┬┐┬ ┬  ╔═╗┌┬┐┬┌┬┐┬┌─┐┌┐┌${endColor}"
		echo -e "${redColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ╚═╗├┤ │  │ │├┬┘│ │ └┬┘  ║╣  │││ │ ││ ││││${endColor}"
		echo -e "${redColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╚═╝└─┘└─┘└─┘┴└─┴ ┴  ┴   ╚═╝─┴┘┴ ┴ ┴└─┘┘└┘${endColor}${yellowColor}ooo${endColor}"
		core_install;
		security_install;
		echo -e "\n\n${dot}${yellowColor}Parrot OS Security Edition Installed!!!${endColor}"
		echo -e "${purpleColor}Estamos Hack - We Hack${endColor}"
		;;

		4) clear;
		echo -e "${purpleColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╦ ╦┌─┐┌┬┐┌─┐  ╔═╗┌┬┐┬┌┬┐┬┌─┐┌┐┌${endColor}"
		echo -e "${purpleColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ╠═╣│ ││││├┤   ║╣  │││ │ ││ ││││${endColor}"
		echo -e "${purpleColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╩ ╩└─┘┴ ┴└─┘  ╚═╝─┴┘┴ ┴ ┴└─┘┘└┘${endColor}${yellowColor}ooo${endColor}"
		core_install;
		home_install;
		echo -e "\n\n${dot}${yellowColor}Parrot OS Home Edition Installed!!!${endColor}"
		;;

		5) clear;
		echo -e "${purpleColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╔═╗┌┬┐┌┐ ┌─┐┌┬┐┌┬┐┌─┐┌┬┐${endColor}"
		echo -e "${purpleColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ║╣ │││├┴┐├┤  ││ ││├┤  ││${endColor}"
		echo -e "${purpleColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╚═╝┴ ┴└─┘└─┘─┴┘─┴┘└─┘─┴┘${endColor}${yellowColor}ooo${endColor}"
		core_install;
		embedded_install;
		echo -e "\n\n${dot}${yellowColor}Parrot OS Embedded Installed!!!${endColor}"
		;;

		6) clear;
		echo -e "${purpleColor} ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┬┌┐┌┌─┐  ╦═╗┌─┐┌─┐┌─┐┌─┐${endColor}"
		echo -e "${purpleColor} ║│││└─┐ │ ├─┤│  │  │││││ ┬  ╠╦╝├┤ ├─┘│ │└─┐${endColor}"
		echo -e "${purpleColor} ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘┴┘└┘└─┘  ╩╚═└─┘┴  └─┘└─┘${endColor}${yellowColor}ooo${endColor}"
		repos_install;
		echo -e "\n\n${dot}${yellowColor}Parrot OS Embedded Installed!!!${endColor}"
		;;

		*)
		error="0"
		menu
		;;
	esac
}

#---------- Installer ----------
if [ `whoami` == "root" ]; then
	init_installer;
else
	echo -e "${yellowColor}R U Drunk? This script needs to be run as ${endColor}${redColor}root${endColor}${yellowColor}!${endColor}";
fi
