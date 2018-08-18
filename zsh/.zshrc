ZSH_THEME="minimal"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
  git
  extract
  pass
  rsync
  tmux
  docker
  gitignore
  go
  node
  npm
  nvm
  zsh-nvm
  archlinux
  battery
)

addToPath() {
  if [[ -d $1 ]]; then
    export PATH=$1:$PATH
  fi
}

export PATH=$HOME/bin:/usr/local/bin:$PATH

addToPath ~/.npm-global/bin
addToPath ~/go/bin

# export UPDATE_ZSH_DAYS=13
# export MANPATH="/usr/local/man:$MANPATH"
export EDITOR=nvim
export ZSH="/home/xdefrag/.oh-my-zsh"
export LANG=en_US.UTF-8

alias v=nvim
alias vi=nvim
alias vim=nvim

alias k=kubectl
alias kgp=kubectl get pods

alias p=pass
alias df=df -h
alias xm=xrdb -merge ~/.Xresources

source $ZSH/oh-my-zsh.sh
