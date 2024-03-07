#!/bin/bash

arch_init() {
	cd ~
	# System upgrade
	sudo pacman -Syu --noconfirm

	# Install some packages
	sudo pacman -S --noconfirm git curl wget zsh neofetch python lua ripgrep bat
	sudo pacman -S --noconfirm neovim

	# Install paru
	sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	cd ~

	# Install packages
	paru -Syu --noconfirm
	paru -S --noconfirm exa yazi #joshuto-bin

	# Clone dotfiles
	rm -rf ~/.zshrc
	git clone https://github.com/jiagengding/.config --depth=1
	cd ~/.config
	rm -rf nvim
	git clone https://github.com/jiagengding/nvim --depth=1
	cd ~

	# Config zsh
	rm .zshrc
	ln -s ~/.config/zsh/zshrc ~/.zshrc
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	sudo chsh -s $(which zsh)

	sudo reboot
}


debian_init() {
  # System upgrade
	cd ~
	sudo apt update && sudo apt upgrade -y

	# Install some packages
	sudo apt install -y git curl wget zsh neofetch python3 lua5.4 exa ripgrep bat yazi
	sudo snap install nvim --classic

	# Install joshuto
	# cargo install --git https://github.com/kamiyaa/joshuto.git --force
	# sudo cp ~/.cargo/bin/joshuto /usr/bin/joshuto

	# Clone dotfiles
	rm -rf ~/.config
	git clone https://github.com/jiagengding/.config --depth=1
	cd ~/.config
	rm -rf nvim
	git clone https://github.com/jiagengding/nvim --depth=1
	cd ~

	# Config zsh
	rm -rf ~/.zshrc
	ln -s ~/.config/zsh/zshrc ~/.zshrc
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	sudo chsh -s $(which zsh)

	sudo reboot
}


if [[ "$(uname)" == "Linux" ]]; then
	if [[ -e "/etc/debian_version" ]]; then
		debian_init
	elif [[ -e "/etc/arch-release" ]]; then
		echo "This is an Arch Linux system."
		arch_init
	else
		echo "Unsupported Linux distribution."
		exit 1
	fi
else
	echo "Unsupported operating system."
	exit 1
fi
