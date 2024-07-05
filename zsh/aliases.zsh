alias zr='nvim ~/.config/zsh/zshrc'
alias szr='source ~/.zshrc'
alias l='ls -al --git --time-style iso'
# alias cd='z'
alias ps=procs
alias i=ipython
alias j=julia
alias m='matlab -nodesktop -nosplash'
alias c='clear'
# alias up='proxy && brew update && brew upgrade && brew cu -a -y && mas upgrade && brew cleanup'
# alias pr='export ALL_PROXY=socks5://127.0.0.1:1080'

alias s=neofetch
alias ml='matlab -nodesktop -nosplash'

# git
alias lg='lazygit'
alias gp='git push'
alias gs='git status'
alias ga='git add'

alias H='cd ~'
alias cc='cd ~/.config'
alias D='cd ~/Desktop'

alias zinitup='zinit self-update && zinit update --parallel'

# joplin
alias o=joplin
alias oe='joplin edit'
alias oc='joplin cat'
alias os='joplin status'
alias oex='joplin export --format md'
alias om='joplin mknote'
alias ot='joplin mktodo'
alias oo='joplin mknote `date +%Y/%m/%d`'
alias ol='joplin ls -l'
alias oss='joplin sync'
alias oh='joplin help all'


# tmux
alias tnew='tmux new -s '
alias tl='tmux ls'
alias tn='tmux rename -t'


# todo.sh & gcalcli
alias t='todo.sh'
alias g='gcalcli'

alias ch='/Applications/Chromium.app/Contents/MacOS/Chromium'

alias b2='backblaze-b2'

# alias for trash-cli
alias rm='trash-put'
alias trl='trash-list'
alias ud='trash-restore'

alias yay='paru'

# Yazi
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(/bin/cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function r() {
    if command -v yazi &> /dev/null; then
        yazi "$@"
    elif command -v joshuto &> /dev/null; then
        joshuto "$@"
    elif command -v ranger &> /dev/null; then
        ranger "$@"
    else
        echo "yazi, joshuto and ranger not found."
    fi
}


function cat() {
	if command -v bat &> /dev/null; then
		bat --color=always --paging=never --style=plain "$@"
	else
		/bin/cat "$@"
	fi
}

function ls() {
	if command -v eza &> /dev/null; then
    # 移除 --color=tty 参数（如果存在），并添加 --color=auto
    local args=()
    for arg in "$@"; do
        if [[ "$arg" != "--color=tty" ]]; then
            args+=("$arg")
        fi
    done
    eza --color=auto "${args[@]}"	
	else
		/bin/ls "$@"
	fi
}

function grep() {
	if command -v rg &> /dev/null; then
		rg "$@"
	else
		/usr/bin/grep "$@"
	fi
}

function find() {
	if command -v fd &> /dev/null; then
		fd "$@"
	else
		/usr/bin/find "$@"
	fi
}

function vim() {
	if command -v nvim &> /dev/null; then
		nvim "$@"
	elif command -v /bin/vim &> /dev/null; then
		/usr/bin/vim "$@"
	else
		/bin/vi "$@"
	fi
}

# proxy activate
proxy () {
	export https_proxy=http://127.0.0.1:7891 http_proxy=http://127.0.0.1:7891 all_proxy=socks5://127.0.0.1:7890
  echo "Proxy on"
}

# proxy deactivate
noproxy () {
  unset http_proxy
  unset https_proxy
  unset all_proxy
  echo "Proxy off"
}


# arch upgrade
arch_upgrade(){
	sudo pacman -Syyu --noconfirm
  # sudo updatedb # Update mlocate database
	sudo conda update conda
	paru -Syu --devel --ignore miniconda3 --noconfirm
  zinit self-update && zinit update --parallel
	pip install --upgrade pip pip-review
	# pip-review --auto
	cd .config && git pull
	cd nvim && git pull
	cd ~
	neofetch
}

arch_backup(){
	cd ~/.config
	comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) > pkg-backup/official-arch-pkglist
	(yay -Qeq|sort) > pkg-backup/all-arch-pkglist
	pip list > pkg-backup/python-pkglist
	cd ~
}


# Clean arch shit files
arch_cleanup(){
  echo ''
  echo '====== rm unused packages ====='
  echo ''
	sudo pacman -Scc
  sudo pacman -Rns $(pacman -Qtdq) # Remove unused packages
  echo ''
  echo '====== rmshit ====='
  echo ''
	cd ~/.config/scripts/
  if [  -f rmshit.py ]; then
     python rmshit.py
  else
		echo "rmshit.py not found!"
		echo 'Downloading....'
		echo ''
		sudo curl -O https://raw.githubusercontent.com/lahwaacz/Scripts/master/rmshit.py
		python rmshit.py
  fi
	cd ~
}

# debian upgrade
deb_upgrade(){
	sudo apt update && sudo apt upgrade -y
	sudo apt autoremove
  zinit self-update && zinit update --parallel
	pip install --upgrade pip
	pip-review --auto
	cd .config && git pull
	cd nvim && git pull
	cd ~
	neofetch
}

# Debian backup
deb_backup(){
	cd .config/pkg-backup
	dpkg --get-selections > deb-pkglist
  cd ~
}

# mac upgrade
mac_upgrade(){
	brew update && brew upgrade
	brew cu -a -y
	# mas upgrade
	brew cleanup
	# npm install -g npm
	# cnpm update joplin -g
  zinit self-update && zinit update --parallel
	pip install --upgrade pip
	pip-review --auto
	cd .config && git pull
	cd nvim && git pull
	cd ~
	echo "Upgrade completed"
	neofetch
}

mac_backup(){
	cd ~/.config/pkg-backup/
	mv Brewfile ~/.Trash
	brew bundle dump
	cd ~
	echo "MacOS Backup completed"
}

# # homebrew upgrade
# up(){
# 	# brew upgrade firefox brave-browser
# 	# export https_proxy=http://127.0.0.1:7891 http_proxy=http://127.0.0.1:7891 all_proxy=socks5://127.0.0.1:7890
#   # echo "Proxy on"
# 	brew update
# 	brew upgrade --greedy
# 	brew cu -a -y
# 	# mas upgrade
# 	brew cleanup
# 	# npm install -g npm
# 	cnpm update joplin -g
# 	cd ~/.config
# 	mv Brewfile ~/.Trash
# 	brew bundle dump
#   zinit self-update && zinit update --parallel
# 	noproxy
# 	cd ~
# 	pip3 install --upgrade pip
# 	pip-review --local --interactive
# 	sudo softwareupdate -i -a
# 	clear
# 	echo "Upgrade completed"
# 	neofetch
# }


# upgrade
up(){
	if [[ "$(uname)" == "Darwin" ]]; then
		mac_upgrade
	elif [[ "$(uname)" == "Linux" ]]; then
		if [[ -e "/etc/arch-release" ]]; then
			arch_upgrade
		elif [[ -e "/etc/debian_version" ]]; then
			deb_upgrade
		else
			echo "Unknown Linux Distribution"
			exit 1
		fi
	else
		echo "Unknown OS"
		exit 1
	fi
}

backup(){
	if [[ "$(uname)" == "Darwin" ]]; then
		mac_backup
	elif [[ "$(uname)" == "Linux" ]]; then
		if [[ -e "/etc/arch-release" ]]; then
			arch_backup
		elif [[ -e "/etc/debian_version" ]]; then
			deb_backup
		else
			echo "Unknown Linux Distribution"
			exit 1
		fi
	else
		echo "Unknown OS"
		exit 1
	fi
}

clean(){
	if [[ "$(uname)" == "Darwin" ]]; then
		if command -v mac-cleanup &>/dev/null; then
			echo "Running cleanup command..."
			mac-cleanup --dry-run
		else
			echo "Cleanup command not found. Installing..."
			wget "https://raw.githubusercontent.com/mac-cleanup/mac-cleanup-sh/main/installer.sh" -O - | bash -s update
			mac-cleanup --dry-run
		fi
	elif [[ "$(uname)" == "Linux" ]]; then
		if [[ -e "/etc/arch-release" ]]; then
			arch_cleanup
		elif [[ -e "/etc/debian_version" ]]; then
			# Clean up unneeded packages
			sudo apt autoremove
			# Clean the APT cache to free up disk space
			sudo apt clean
		else
			echo "Unknown Linux Distribution"
			exit 1
		fi
	else
		echo "Unknown OS"
		exit 1
	fi
}
