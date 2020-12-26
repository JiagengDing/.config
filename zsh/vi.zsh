# bindkey '^v' edit-command-line
bindkey -v
bindkey -M vicmd "k" vi-insert
bindkey -M vicmd "K" vi-insert-bol
bindkey -M vicmd "n" vi-backward-char
bindkey -M vicmd "i" vi-forward-char
bindkey -M vicmd "N" vi-beginning-of-line
bindkey -M vicmd "I" vi-end-of-line
bindkey -M vicmd "e" down-line-or-history
bindkey -M vicmd "u" up-line-or-history
bindkey -M vicmd "l" undo
#bindkey -M vicmd "-" vi-rev-repeat-search
bindkey -M vicmd "=" vi-repeat-search
bindkey -M vicmd "h" vi-forward-word-end
