#!/bin/bash

#Assume this repo was cloned to ~/.config/awesome/
awesome_repo="$HOME/.config/awesome"

#Run with sudo
# [ "$UID" -eq 0 ] || { echo "This script m ust be run as root."; exit 1;}

deps=(
  # Desktop
  xorg{,-xinit}
  xsel
  awesome
  picom #Regular picom will do, but i recommend using picom-ibhagwan-git from aur
  nitrogen
  rofi
  lxappearance
  gnome-themes-extra
  lxqt-policykit
  pcmanfm
  ffmpegthumbnailer
  gvfs
  xarchiver
  unzip
  unrar
  p7zip
  atril
  gtk3
  adwaita-qt5
  cutefish-icons
  usbutils
  udisks2
  rclone
  gdu
  bleachbit

  # Media
  gpicview
  gpick
  inkscape
  lxmusic
  vlc

  #Editors
  vim
  neovim
  python-neovim
  code

  #Clipboard manager
  copyq

  #Screenshots
  flameshot

  #Password manager
  keepassxc

  git
  ssh-tools

  #Browsers
  firefox
  firefox-developer-edition
  chromium

  #The only thing Skype works with
  gnome-keyring

  #Sound
  pipewire{,-jack,-pulse,-alsa}
  wireplumber

  #Fonts
  ttf-dejavu
  noto-fonts{-emoji,-cjk}
)

# This packages won't be installed. They will be downloaded to ~/aur.
# You need to manually review them and run makepkg -si
aur_deps=(
  skypeforlinux-stable-bin
  webstorm
  postman-bin
)

#install required packages
sudo pacman -Syu "${deps[@]}" --noconfirm --needed

# link configs
ln -sf "$awesome_repo/rofi" "$HOME/.config/rofi"

# download AUR packages
for pkg in "${aur_deps[@]}"; do
  git clone "https://aur.archlinux.org/$pkg.git" "$HOME/aur/$pkg"
done


# download wallpapers
wp_dir="$HOME/pictures/wallpapers"

if [ ! -d "$wp_dir" ]; then
  mkdir "$wp_dir"
  git clone https://gitlab.com/exorcist365/wallpapers.git "$wp_dir"
fi

#install bundled fonts
for dir in $awesome_repo/fonts/; do
  sudo cp "$dir/usr" "/"
done
