# Void Linux Post Installation

Time to install real stuff.

## Connect to the Internet

Ethernet doesn't need anything else. For Wi-Fi, for now use `wpa_cli`:

```sh
# Reconnect to the internet if you are on Wi-Fi.
sudo ln -s /etc/sv/dhcpcd /var/service
sudo ln -s /etc/sv/wpa_supplicant /var/service

```

## Continue with SSH

SSH from another system is much easier. Let's do that:

```sh
sudo ln -s /etc/sv/sshd /var/service
```

## Update System & Baseline

Update the system, get a baseline by installing packages like `xtools` and
enabling addition repositories:

```sh
sudo xbps-install -Syu
sudo xbps-install -Sy xtools
xi void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
xi -Su
```

## AMD Firmware

```sh
xi linux-firmware-amd vulkan-loader mesa-dri mesa-vulkan-radeon mesa-vaapi \
   mesa-vdpau mesa-dri-32bit vulkan-loader-32bit mesa-vulkan-radeon-32bit
```

## NVIDIA Firmware

```sh
# for new models
xi nvidia nvidia-libs-32bit vulkan-loader vulkan-loader-32bit

# for older models, like gtx 1070
xi nvidia580 nvidia580-libs-32bit vulkan-loader vulkan-loader-32bit

sudo bash -c 'cat <<EOF > "/etc/modprobe.d/nvidia_drm.conf"
options nvidia_drm modeset=1
EOF'
```

## Intel Firmware

```sh
xi linux-firmware-intel mesa-vulkan-intel intel-video-accel mesa-dri \
   vulkan-loader mesa-vulkan-intel-32bit mesa-dri-32bit vulkan-loader-32bit \
   intel-ucode linux-firmware
```

## Other Firmware

```sh
# Gamepads
xi xpadneo xone
```

## Fonts

```sh
xi noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji nerd-fonts-symbols-ttf \
   font-iosevka

# Improve font rendering
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo xbps-reconfigure -f fontconfig
```

## Cron Jobs

```sh
xi snooze
sudo ln -s /etc/sv/snooze-daily /var/service
sudo ln -s /etc/sv/snooze-weekly /var/service
sudo mkdir -p /etc/cron.weekly
sudo bash -c 'cat <<EOF > "/etc/cron.weekly/pio_maintain"
#!/bin/sh
fstrim /
vkpurge rm all
EOF'
sudo chmod +x /etc/cron.weekly/pio_maintain
```

## System Services

```sh
xi elogind
sudo ln -s /etc/sv/dbus /var/service

xi pipewire
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
sudo mkdir -p /etc/xdg/autostart
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart

xi chrony
sudo ln -s /etc/sv/chronyd /var/service

xi bluez libspa-bluetooth
sudo usermod -aG bluetooth $USER
sudo ln -s /etc/sv/bluetoothd /var/service
```

## KDE

```sh
xi kde-plasma kde-baseapps dolphin kdegraphics-thumbnailers ffmpegthumbs ark \
   spectacle xorg-minimal gwenview evince ocean-sound-theme plasma-browser-integration
```

## Custom XDG Directories

```sh
cd ~
rm -rf Desktop Documents Music Public Templates Videos Downloads Pictures Projects
mkdir -p download picture
mkdir -p 3pp/pio-xdg
cd 3pp/pio-xdg
mkdir Desktop Documents Music Public Templates Videos Projects
```

## Service Logging

```sh
xi socklog-void
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/nanoklogd /var/service
sudo usermod -aG socklog $USER
```

## Dotfiles

```sh
cd ~
git clone https://github.com/xinoip/dotfiles
cd dotfiles
xi stow zsh
rm -rf ~/.config/user-dirs.dirs
stow zsh nvim kitty tmux xdg git lazygit mangohud pulse tealdeer wget
sudo bash -c 'cat <<EOF >> "/etc/zsh/zshenv"
export ZDOTDIR=~/.config/zsh
EOF'
chsh --shell /usr/bin/zsh
```

## All the Software

```sh
# Terminal
xi -y zsh kitty tmux wl-clipboard fzf ripgrep fd jq lsd bat procs tealdeer stow

# Fancy
xi -y lolcat-c figlet ufetch cowsay asciinema wiki-tui

# Monitoring
xi -y btop dust duf baobab gparted lshw openrgb bootchart2 vsv progress \
   xrandr

# Files
xi -y yazi xz 7zip 7zip-unrar unrar unzip unp trash-cli

# Toolchains
xi -y base-devel go cargo clang llvm clang-tools-extra n cmake ninja

# Development
xi -y vim neovim tree-sitter tree-sitter-devel vscode lazygit git-filter-repo delta \
   man-pages-devel man-pages-posix prelink tokei docker lazydocker docker-buildx \
   android-tools

# Networking
xi -y wireshark wireshark-qt termshark nmap mtr inetutils-telnet bind-utils \
   wireguard-tools ipcalc iotop

# Internet
xi -y chromium firefox qbittorrent nicotine+ kdeconnect

# Gaming
xi -y steam libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mono gamemode \
   MangoHud gamescope
# Steam 32 Bit Dependencies
xi -y gtk+ gtk+-32bit libICE libICE-32bit libnm libnm-32bit libopenal \
   libopenal-32bit libpipewire libpipewire-32bit SDL2 SDL2-32bit libva libva-32bit \
   libvdpau libvdpau-32bit MangoHud-mangoapp

# Better Sound
xi -y easyeffects lsp-plugins soundconverter

# Docs
xi -y pandoc ImageMagick poppler libreoffice
```

## System Limits

```sh
sudo bash -c 'cat <<EOF >> "/etc/security/limits.conf"
* hard nofile 524288
EOF'
sudo bash -c 'cat <<EOF >> "/etc/sysctl.conf"
vm.max_map_count=1048576
fs.inotify.max_user_instances = 256
EOF'
sudo sysctl -p
```

## Better Battery

```sh
xi tlp powertop
sudo ln -s /etc/sv/tlp /var/service
```

## Node Setup

```sh
N_PREFIX=$HOME/3pp/node n lts
xi pnpm
```

## Void Packages Repository

```sh
cd ~/3pp
git clone https://github.com/xinoip/void-packages.git --depth=1
cd void-packages
./xbps-src binary-bootstrap
echo XBPS_ALLOW_RESTRICTED=yes >>etc/conf

cd ~/3pp/void-packages
./personal/repkg_all.sh
xi brave-origin
```

## Docker

```sh
sudo ln -s /etc/sv/docker /var/service
sudo usermod -aG docker $USER
```

## Flatpak

```sh
xi flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub net.davidotek.pupgui2
sudo flatpak install flathub com.dec05eba.gpu_screen_recorder
sudo flatpak install flathub com.github.Matoking.protontricks
sudo flatpak install flathub com.github.tchx84.Flatseal
```

## Switch to Network Manager

```sh
# You will probably lose connection.
xi NetworkManager
sudo delf /var/service/dhcpcd /var/service/wpa_supplicant && \
sudo ln -s /etc/sv/NetworkManager /var/service
```

## Reconfigure Packages

```sh
sudo xbps-reconfigure -fa
```

## Enable Display Server

```sh
sudo ln -s /etc/sv/sddm /var/service
```

## Additional Steps for KDE

- Go over System Settings
- Turn on "Automatic Login"
- Enable swapfile
