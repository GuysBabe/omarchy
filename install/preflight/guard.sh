#!/bin/bash

abort() {
  echo -e "\e[31mOmarchy install requires: $1\e[0m"
  echo
  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

# Must be CachyOs
[[ -f /etc/arch-release && -f /etc/cachyos-release ]] || abort "CachyOs"

# Must not be an Arch derivative distro (other than CachyOs)
for marker in /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  [[ -f "$marker" ]] && abort "CachyOs"
done

# Must not be runnig as root
[ "$EUID" -eq 0 ] && abort "Running as user (not root)"

# Must be x86 only to fully work
[ "$(uname -m)" != "x86_64" ] && abort "x86_64 CPU"

# Must not have Gnome or KDE already install
pacman -Qe gnome-shell &>/dev/null && abort "Fresh + CachyOs"
pacman -Qe plasma-desktop &>/dev/null && abort "Fresh + CachyOs"

# Cleared all guards
echo "Guards: OK"
