# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"


# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

alias gitlog='git log --graph --pretty=format:"%Cgreen%h%Creset - %Cblue(%ci) -%C(red)%d%Creset %s %C(yellow)<%an>%Creset" --abbrev-commit --'
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx ruby gem history brew colorize colored-man capistrano git gitfast postgres pow rails rsync rbenv sublime themes pass zsh-syntax-highlighting history-substring-search bundler)
# vi-mode zeus vagrant node npm  git-extras github)

#####################
##bashrc
# Colorize the Terminal
export CLICOLOR=1;

# export CURL_CA_BUNDLE=/usr/local/share/ca-bundle.crt
# export CURL_CA_BUNDLE=/usr/local/Cellar/curl-ca-bundle/1.87/share/ca-bundle.crt
#export CURL_CA_BUNDLE=/usr/local/Cellar/curl-ca-bundle/1.87/share/cacert.pem
# export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home/
export CPPFLAGS=-I/opt/X11/include

export EDITOR='s'

export SHELL=/bin/bash

export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# Finished adapting your PATH environment variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH

# getting utf-8 support
export LC_CTYPE=de_DE.UTF-8

# automatically include cucumber features while using autotest
# export AUTOFEATURE=true

# aliases for listing directories
alias ll="ls -l"
alias l="ls -al"

alias ref='find app lib  -iname "*.rb" | xargs grep -h "^[[:space:]]*class\|module\b" | sed "s/[[:space:]]*//" | cut -d " " -f 2 | while read class; do echo `grep -rl "\b$class\b" app lib --include="*.rb" | wc -l` $class; done | sort -n'

# Git aliases for bash
alias gst='git status -s'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias grma='git ls-files --deleted | xargs git rm'
alias ho="subl /etc/hosts"
alias s="subl"
alias s.="s ."
alias ars="sudo /usr/sbin/httpd -k restart"
alias prs="touch tmp/restart.txt"
alias door='echo b178cb7f37f70e1c2cf9dd3a53c7|nc 192.168.23.187 9999'
alias ssh_jen='ssh mb@46.237.200.174 -p56214 -NL8080:localhost:80'

alias reload=". ~/.zshrc"

# git update master and rebase to current branch
function gumarc {
  remembered_branch="$(current_branch)"

  git stash
  git fetch -p
  git checkout master
  git rebase origin/master

  bundle install
  # rake db:migrate
  # RAILS_ENV=test rake db:migrate

  git checkout $remembered_branch
  git rebase master
  git stash pop
}

# $ ghpr 516
# Create this pull into (d)evelop / (m)aster?
# $ m
# hub pull-request -i 516 -b master -h 516-use-money-helpers-in-order-checkout-views
# Create this pull request? y/Y/...
# $ y
function ghpr {
  if [[ -z "$1" ]]
    then
      echo "Pull request aborted. Pleaase specify a issue number."
      return
  fi

  branch="$(git branch | ack -1 $1)"
  short_branch=$branch[3,-1]

  echo "Create this pull into (d)evelop / (m)aster?"
  read -rs -k 1 ans

  case "${ans}" in
    d|$'\n')
      main_branch="develop"
      ;;
    m|$'\n')
      main_branch="master"
      ;;
    *)
      echo "Pull request aborted"
      return
      ;;
  esac

  # echo "set organisation"
  # read organisation

  request="hub pull-request -i $1 -b $main_branch -h $short_branch"

  echo "$request"
  echo "Create this pull request? y/Y/..."

  read -rs -k 1 ans

  case "${ans}" in
    y|Y|$'\n')
      eval $request
      ;;
    *)
      echo "Pull request aborted"
      return
      ;;
  esac
}

function guder {
  remembered_branch="$(current_branch)"

  git stash
  git fetch -p
  git checkout develop
  git rebase origin/develop

  bundle install

  git checkout $remembered_branch
  git rebase develop
  git stash pop
}

# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh {
  giturl=$(git config --get remote.origin.url)
  if [[ "$giturl" == "" ]]
    then
      echo "Not a git repository or no remote.origin.url set"
      return
  fi
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" || "(unnamed branch)"
  branch=${branch#\refs/heads/}
  giturl=$giturl$branch
  open $giturl
}
# export PGHOST=localhost
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# Customize to your needs...
export PATH=$PATH:$HOME/bin:/usr/local/heroku/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/X11/bin:$HOME/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin
# export PATH=$PATH:$HOME/bin:/usr/local/heroku/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/X11/bin:$HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin
export PATH="$HOME/.rbenv/bin:$PATH"
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

#export DYLD_LIBRARY_PATH: /usr/local/mysql/lib:/usr/local/mysql/lib:/usr/local/mysql/lib:


# Applications/Postgres.app/Contents/MacOS/bin
# http://stackoverflow.com/questions/19630154/gem-install-therubyracer-v-0-10-2-on-osx-mavericks-not-installing/19762877
# export CC=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2
# export CXX=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2
# export CPP=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/cpp-4.2
#####

# cert.pem file for openssl
# export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem

# https://github.com/robbyrussell/oh-my-zsh/issues/1433#issuecomment-38358007
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

eval "$(rbenv init -)"

# has to be the last command !!
source $ZSH/oh-my-zsh.sh
