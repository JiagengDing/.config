##################################3
#zinit
#################################33

# Load powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh

# A.
setopt promptsubst

# B.
zinit wait lucid for \
        OMZL::git.zsh \
        OMZL::history.zsh \
        OMZL::key-bindings.zsh \
        OMZL::theme-and-appearance.zsh \
				OMZP::sudo/sudo.plugin.zsh \
				atload"_zsh_autosuggest_start" \
							 zsh-users/zsh-autosuggestions \
				blockf atpull'zinit creinstall -q .' \
									    zsh-users/zsh-completions
  # atload"unalias grv" \
  #       OMZP::git

PS1="READY >" # provide a simple prompt till the theme loads

# C.
zinit wait'!' lucid for \
		OMZL::prompt_info_functions.zsh \
		OMZT::gnzh

# D.
zinit wait lucid for \
  atinit"zicompinit; zicdreplay"  \
        zdharma-continuum/fast-syntax-highlighting \
      OMZP::colored-man-pages \
  as"completion" \
        OMZP::docker/_docker


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# # 快速目录跳转
# zinit ice lucid wait='1'
# zinit light skywind3000/z.lua
#
# # 语法高亮
# zinit ice lucid wait='0' atinit='zpcompinit'
# zinit light zdharma/fast-syntax-highlighting
#
# # 自动建议
# zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
# zinit light zsh-users/zsh-autosuggestions
#
# # 补全
# zinit ice lucid wait='0'
# zinit light zsh-users/zsh-completions
#
# # 加载 OMZ 框架及部分插件
# zinit snippet OMZL::completion.zsh
# zinit snippet OMZL::history.zsh
# zinit snippet OMZL::key-bindings.zsh
# zinit snippet OMZL::theme-and-appearance.zsh
# zinit snippet OMZP::colored-man-pages/colored-man-pages.plugin.zsh
# zinit snippet OMZP::sudo/sudo.plugin.zsh
#
# zinit ice svn
# zinit snippet OMZP::extract
#
# zinit ice lucid wait='1'
# zinit snippet OMZP::git/git.plugin.zsh
