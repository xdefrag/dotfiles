ZSH_THEME="minimal"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
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
  osx
  autojump
)

addToPath() {
  if [[ -d $1 ]]; then
    export PATH=$1:$PATH
  fi
}

export PATH=$HOME/bin:/usr/local/bin:$PATH

addToPath /usr/local/opt/openal-soft/bin
addToPath ~/.npm-global/bin
addToPath ~/go/bin
addToPath /usr/local/sbin
addToPath ~/.local/bin
addToPath /usr/local/opt/make/libexec/gnubin
addToPath ~/.cabal/bin
addToPath /usr/local/opt/llvm/bin
addToPath /usr/local/opt/texinfo/bin
addToPath /Library/TeX/texbin
addToPath /Library/Frameworks/Mono.framework/Versions/Current/Commands

export EDITOR=nvim

[ -d /Users/stanislaw.karkavin ] && export ZSH="/Users/stanislaw.karkavin/.oh-my-zsh"
[ -d /Users/xdefrag ] && export ZSH="/Users/xdefrag/.oh-my-zsh"

export LANG=en_US.UTF-8
export GOPATH=~/go
export GOBIN=~/go/bin

export GO111MODULE=on

alias v=nvim
alias vi=nvim
alias vim=nvim

alias k=kubectl
alias kgp=kubectl get pods

alias e=etcdctl

alias p=pass
alias df=df -h

# Zsh
source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=~/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo ] && source ~/.cargo/env
[ -f ~/.phpbrew ] && source ~/.phpbrew/bashrc
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Homebrew llvm
addToPath "/usr/local/opt/llvm/bin"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

export LDFLAGS="-L/usr/local/opt/openal-soft/lib"
export CPPFLAGS="-I/usr/local/opt/openal-soft/include"

export PKG_CONFIG_PATH="/usr/local/opt/openal-soft/lib/pkgconfig"

export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"

export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

# jenv config
export PATH="/Users/xdefrag/.jenv/shims:${PATH}"
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
source '/usr/local/Cellar/jenv/0.5.2/libexec/libexec/../completions/jenv.zsh'
jenv rehash 2>/dev/null
jenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi
  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}
