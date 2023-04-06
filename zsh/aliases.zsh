alias zr='nvim ~/.config/zsh/zshrc'
alias szr='source ~/.zshrc'
# alias l='ls -al'
alias ls='exa'
alias l='exa --long --all --git --time-style iso'
# alias cd='z'
# alias cat='bat'
alias r=ranger
alias i=ipython
alias j=julia
alias m='matlab -nodesktop -nosplash'
alias c='clear'
# alias up='proxy && brew update && brew upgrade && brew cu -a -y && mas upgrade && brew cleanup'
# alias pr='export ALL_PROXY=socks5://127.0.0.1:1080'

alias s=neofetch
alias vi=/bin/vim
alias vim=nvim
alias ml='matlab -nodesktop -nosplash'

##############
# git
##############
alias lg='lazygit'
alias gp='git push'
alias gs='git status'
alias ga='git add'

alias H='cd ~'
alias cc='cd ~/.config'
alias D='cd ~/Desktop'

alias zinitup='zinit self-update && zinit update --parallel'

###############
## joplin
###############
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


###############
## tmux
###############
alias tnew='tmux new -s '
alias tl='tmux ls'
alias tn='tmux rename -t'


###############
## todo.sh & gcalcli
###############
alias t='todo.sh'
alias g='gcalcli'

alias ch='/Applications/Chromium.app/Contents/MacOS/Chromium'

alias b2='backblaze-b2'

#防止出现删除错误的问题
# alias rm='deletefile'
alias rl='trashlist'
alias ur='undeletefile'
alias mycl='cleartrash'



# 启动代理
proxy () {
	export https_proxy=http://127.0.0.1:7891 http_proxy=http://127.0.0.1:7891 all_proxy=socks5://127.0.0.1:7890
  echo "Proxy on"
}

# 关闭代理
noproxy () {
  unset http_proxy
  unset https_proxy
  unset all_proxy
  echo "Proxy off"
}

# arch upgrade
archup(){
	sudo powerpill -Syyu
  sudo updatedb # Update mlocate database
	yay -Syu
  zinit self-update && zinit update --parallel
	pip install --upgrade pip pip-review
	pip-review --auto
	cd .config && git pull
	comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) > pkg-backup/official-arch-pkglist
	(yay -Qeq|sort) > pkg-backup/all-arch-pkglist
	pip list > pkg-backup/python-pkglist
	cd nvim && git pull
	cd ~
	neofetch
}


# Clean arch shit files
archclean(){
  echo ''
  echo '====== rm unused packages ====='
  echo ''
	sudo pacman -Scc
  sudo pacman -Rns $(pacman -Qtdq) # Remove unused packages
  echo ''
  echo '====== rmshit ====='
  echo ''
	cd .config/scripts/
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
debup(){
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

# mac upgrade
upp(){
	brew update && brew upgrade
	brew cu -a -y
	# mas upgrade
	brew cleanup
	# npm install -g npm
	# cnpm update joplin -g
	cd ~/.config/pkg-backup/
	mv Brewfile ~/.Trash
	brew bundle dump
	cd ~
  zinit self-update && zinit update --parallel
	pip install --upgrade pip
	pip-review --auto
	cd .config && git pull
	cd nvim && git pull
	cd ~
	echo "Upgrade completed"
	neofetch
}

# homebrew upgrade
up(){
	# brew upgrade firefox brave-browser
	# export https_proxy=http://127.0.0.1:7891 http_proxy=http://127.0.0.1:7891 all_proxy=socks5://127.0.0.1:7890
  # echo "Proxy on"
	brew update
	brew upgrade --greedy
	brew cu -a -y
	# mas upgrade
	brew cleanup
	# npm install -g npm
	cnpm update joplin -g
	cd ~/.config
	mv Brewfile ~/.Trash
	brew bundle dump
  zinit self-update && zinit update --parallel
	noproxy
	cd ~
	pip3 install --upgrade pip
	pip-review --local --interactive
	sudo softwareupdate -i -a
	clear
	echo "Upgrade completed"
	neofetch
}



#替换rm指令移动文件到~/.trash/中
deletefile()
{
   mv $@  ~/.local/share/Trash/files
}
#显示~/.trash/中内容
trashlist()
{
   echo -e "\a[========================== ls trash ==========================]"
   ls -ail  ~/.local/share/Trash/files
   echo -e "\a[==========================  ls end ===========================]"
}
#将被删除文件还原到当前目录
undeletefile()
{
   mv -i ~/.local/share/Trash/files/$@ ./
}
#清空回收站
cleartrash()
{
   echo -ne "\a[====================== Clear ~/.trash, Sure? =================] [y/n] >_"
   read confirm
   if [ $confirm == 'y' -o $confirm == 'Y' ] ;then
      /bin/rm -rf ~/.local/share/Trash/files/*
      /bin/rm -rf ~/.local/share/Trash/files/.* 2>/dev/null
      echo -e "\a[===================== Clear Successfully =====================]\a"
   fi
}
