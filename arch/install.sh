#!/bin/bash

# "bash strict mode"
set -euo pipefail
IFS=$'\n\t'

if [[ $EUID -ne 0 ]]; then
	# root only
	echo "This script must be run as root"
	exit 1
fi

if [ ! -f "/etc/arch-release" ]; then
	# arch only
	echo "This script is only intended to run on Arch Linux"
	exit 1
fi

echo "Killing gpg-agent processes and emptying out pacmans gnupg directory"
sleep 2
killall gpg-agent
rm -rf /etc/pacman.d/gnupg/*

echo "Initializing and populating pacmans keyring"
sleep 2
pacman-key --init || { echo "Failed to initialize pacmans keyring"; exit 1; }
pacman-key --populate archlinux || { echo "Failed to populate pacmans keyring"; exit 1; }

echo "Disabling download timeout on packages"
sleep 1
if ! perl -pi -e '$_ .= qq(DisableDownloadTimeout\n) if /# Misc options/' /etc/pacman.conf; then
	echo "Failed to disable download timeout on packages"
	exit 1
fi

echo "Enabling color in the terminal"
sleep 1
if ! sed -i 's/#Color/Color/' /etc/pacman.conf; then
	echo "Failed to enable color in the terminal"
	exit 1
fi

echo "Updating internal database and checking for updates specific to these pkgs: archlinux-keyring, archinstall, reflector, python, python-setuptools, jq"
sleep 1
if ! pacman -Syy --needed archlinux-keyring archinstall reflector python python-setuptools jq; then
	echo "Failed to update internal database and failed to check for updates specific to these pkgs: archlinux-keyring, archinstall, reflector, python, python-setuptools, jq"
	exit 1
fi

echo "Enabling parallel downloads and setting the max to 25"
sleep 1
prlDownloads() {
	modified_config=$(jq '.["parallel downloads"] = 25' <<< $(cat config.json))
	echo "$modified_config" >> temp_config.json
	mv temp_config.json config.json
	sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 25/' /etc/pacman.conf
}
if ! prlDownloads; then
	echo "Failed to enable parallel downloads"
	exit 1
fi

hostnamePush () {
	read -e -p "Hostname: " -i "changethishostname" hostname
	modified_config=$(jq --arg item "$hostname" '.hostname = $item' <<< $(cat config.json))
	echo "$modified_config" >> temp_config.json
	mv temp_config.json config.json
}
if ! hostnamePush; then
	echo "Hostname import failed";
	exit 1
fi

usernamePush () {
	read -e -p "Username: " -i "" usrname
	modified_creds=$(jq --arg item "$usrname" '.["!users"][0]["username"] = $item' <<< $(cat creds.json))
	echo "$modified_creds" >> temp_creds.json
	mv temp_creds.json creds.json
}
if ! usernamePush; then
	echo "Username creds import failed";
	exit 1
fi

passwordPush () {
	read -e -p "Password (hidden for security): " -i "" passwd
	modified_creds=$(jq --arg item "$passwd" '.["!users"][0]["!password"] = $item' <<< $(cat creds.json))
	echo "$modified_creds" >> temp_creds.json
	mv temp_creds.json creds.json
}
if ! passwordPush; then
	echo "Password creds import failed";
	exit 1
fi

aurPkgsParse () {
	read -e -p "Optional AUR Pkgs (suggested apps prefilled): " -i "yay-bin " aur_pkgs
	modified_config=$(jq --arg items "$aur_pkgs" '.packages += ($items | split(" "))' <<< $(cat config.json))
	echo "$modified_config" >> temp_config.json
	mv temp_config.json config.json
}
if ! aurPkgsParse; then
	echo "AUR packages import failed";
fi

echo "Installing with partly generated config, review disk options please..."
sleep 3

if ! archinstall --config config.json --creds creds.json --plugin https://archlinux.life/aur; then
	echo "SYSTEM: Failed to install"
	exit 1
fi

echo "APPLYING THEMES TO GTK FLATPAK APPS: itsfoss.com/flatpak-app-apply-theme"
sleep 2

echo "PLEX USERS: ACCESS http://localhost:32400/web/ FOR CONFIGURATION"
sleep 2

echo "Done!... hopefully | More to do at github.com/chrislowles/nix under arch/extra.sh if you want :)"