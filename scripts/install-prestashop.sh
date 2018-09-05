#!/usr/bin/env bash

# Check if Prestashop has been installed

if [ -f /home/vagrant/.prestashop ]
then
    echo "Prestashop already installed."
    exit 0
fi

# Determine version from config

set -- "$1"
IFS="."; declare -a version=($*)

if [ -z "${version[1]}" ]; then
    installVersion=""
else
    installVersion="$1"
fi

# Check version

IFS='.' read -r -a installVersionSplited <<< "$installVersion"


if [ $installVersionSplited[1] = "7" ]
then
    # Install Prestashop v1.7

    installVersion+='.x'
    echo "Installing Prestashop ${installVersion}"
    cd /home/vagrant
    git clone -b "${installVersion}" https://github.com/PrestaShop/PrestaShop.git ./code
    cd code

    composer install
else
    # Install Prestashop v1.6

    installVersion+='.x'
    echo "Installing Prestashop ${installVersion}"
    cd /home/vagrant
    git clone -b "${installVersion}" https://github.com/PrestaShop/PrestaShop.git ./code
fi

touch /home/vagrant/.prestashop