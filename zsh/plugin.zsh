##################################
# Zinit Config
##################################

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# A. Load without Turbo mode
setopt promptsubst

zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit snippet OMZL::history.zsh

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# B. Load after prompt
zstyle ':omz:alpha:lib:git' async-prompt no
zinit lucid wait for \
        OMZL::git.zsh \
        OMZL::theme-and-appearance.zsh \
				OMZP::sudo/sudo.plugin.zsh \
				atload"_zsh_autosuggest_start" \
							 zsh-users/zsh-autosuggestions \
				blockf atpull'zinit creinstall -q .' \
									    zsh-users/zsh-completions \
			 atload"unalias grv" \
							OMZP::git

PS1="READY >" # provide a simple prompt till the theme loads


# C. Load after prompt and reset prompt
zinit lucid wait'!' for \
		OMZL::prompt_info_functions.zsh \
		OMZT::gnzh


# D. Some plugins
zinit lucid wait for \
  atinit"zicompinit; zicdreplay"  \
        zdharma-continuum/fast-syntax-highlighting \
        OMZP::colored-man-pages \
  as"completion" \
        OMZP::docker/completions/_docker

# zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
# zinit light sharkdp/bat


# E. Load after 1 or 2 seconds
zinit lucid wait"1" for \
    OMZP::extract/extract.plugin.zsh \
		OMZP::command-not-found \
    OMZP::docker/docker.plugin.zsh \
		OMZP::systemd/systemd.plugin.zsh \
  	hlissner/zsh-autopair \
  	skywind3000/z.lua

# zinit as"null" lucid wait"2" from"gh-r" for \
#     mv"exa* -> exa" sbin       ogham/exa \
#     mv"fd* -> fd" sbin"fd/fd"  @sharkdp/fd \
#     sbin"fzf"  junegunn/fzf-bin

# zinit ice svn
