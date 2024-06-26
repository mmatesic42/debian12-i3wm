#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# xorg display server installation
sudo apt install -y xorg brightnessctl xbindkeys xvkbd xinput xorg-dev

# Python installed for bumblebee-status. PACKAGE INCLUDES build-essential.
sudo apt install -y build-essential python3-pip 

# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -y intel-microcode 

# Network Manager
sudo apt install -y policykit-1-gnome network-manager network-manager-gnome

# Installation for Appearance management
sudo apt install -y lxappearance 

# File Manager (eg. pcmanfm,krusader)
sudo apt install -y thunar xfce4-settings xfce4-power-manager

# Network File Tools/System Events
sudo apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends pdfarranger wmctrl

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# Terminal (eg. terminator,kitty,xfce4-terminal,tilix)
sudo apt install -y kitty

# Sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa pamixer

# Neofetch/HTOP
sudo apt install -y neofetch htop

# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
sudo apt install -y exa

# Printing and bluetooth (if needed)
sudo apt install -y cups
sudo apt install -y bluez blueman

sudo systemctl enable bluetooth
sudo systemctl enable cups

# Browser Installation (eg. chromium)
sudo apt install -y firefox-esr 

# Desktop background browser/handler 
# feh --bg-fill /path/to/directory 
# example if you want to use in autostart.sh for i3-gaps
# sudo apt install -y nitrogen 
sudo apt install -y feh


# Packages needed i3-gaps after installation
sudo apt install -y dmenu sxhkd numlockx rofi dunst libnotify-bin picom unzip simple-scan

# Command line text editor -- nano preinstalled  -- I like micro but vim is great
#sudo apt install -y micro
sudo apt install -y neovim

# Install fonts
sudo apt install fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus fonts-cascadia-code

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Install i3 gaps
cd
#cd Downloads
#git clone https://github.com/Airblader/i3 i3-gaps
#cd i3-gaps
#mkdir -p build && cd build
#meson --prefix /usr/local
#ninja
#sudo ninja install
sudo apt install -y i3 i3blocks
# Dependencies for Ly Console Manager
#sudo apt install -y libpam0g-dev libxcb-xkb-dev

# Install Ly Console Display Manager
#cd 
#cd Downloads
#git clone --recurse-submodules https://github.com/fairyglade/ly
#cd ly/
#make
#sudo make install installsystemd
#sudo systemctl enable ly.service

# Lightdm can be used instead of Ly (more common)
# comment out all ly console display if choosing lightdm
sudo apt install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings slick-greeter
sudo systemctl enable lightdm


# XSessions and i3.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=i3
Comment=Dynamic window manager
Exec=i3
Icon=i3
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/i3.desktop;rm ./temp

########################################################
# End of script for default config
#

## These two scripts will install nerdfonts and copy my configuration files into the ~/.config directory
## Configuration uses 

source ~/debian12-i3wm/nerdfonts.sh
rsync -a "$PWD"/dotfiles/etc/skel/ "$HOME"/
sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
