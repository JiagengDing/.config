# System upgrade
cd ~
sudo apt update && sudo apt upgrade -y

# Install some packages
sudo apt install -y git curl wget zsh neofetch python3 lua5.4 exa ripgrep bat cargo
sudo snap install nvim --classic

# Install joshuto
cargo install --git https://github.com/kamiyaa/joshuto.git --force
sudo cp ~/.cargo/bin/joshuto /usr/bin/joshuto

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
