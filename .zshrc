export PATH=$PATH:~/bin
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME
export DOTFILES=$HOME/dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source $HOME/.zshenv

eval "$(rbenv init - zsh)"
eval "$(starship init zsh)"
eval "$(anyenv init -)"

alias ls lsd
alias l ls
alias ll "ls -la"

alias g='git'
alias be='bundle exec'
alias grass='emoji-grass yana-gi'

setopt interactivecomments
setopt correct
setopt nolistbeep

#PATHの重複を絞る
typeset -U

autoload -Uz vcs_info
autoload -Uz compinit && compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s /Users/yana/.autojump/etc/profile.d/autojump.sh ]] && source /Users/yana/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
