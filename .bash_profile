# echo "entering .bash_profile"
export bp=true
# figure out if we are in an interactive shell for use later
[[ $- == *i* ]] && Interactive='true' || Interactive='false'

if $Interactive == 'true'; then
  cowsay $(fortune)
  eval "$(thefuck --alias)"

  # Kubernetes
  #      set editor for kubectl
  export KUBE_EDITOR='code --wait'

  # Homebrew
  # export HOMEBREW_UPGRADE_CLEANUP=1

  # rbenv
  eval "$(rbenv init -)"

# virtualenv
# set -x
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# export WORKON_HOME=~/virtualenvs
# export PROJECT_HOME=~/git/cloud
# source /usr/local/bin/virtualenvwrapper.sh
# alias noenv='deactivate'
# autoenv
# source /usr/local/opt/autoenv/activate.sh
# set +x
fi #end if $Interactive == 'true'

# Setup tab and window title functions for iterm2
# iterm behaviour: until window name is explicitly set, it'll always track tab title.
# So, to have different window and tab titles, iterm_window() must be called
# first. iterm_both() resets this behaviour and has window track tab title again).
# Source: http://superuser.com/a/344397
set_iterm_name() {
  mode=$1
  shift
  echo -ne "\033]$mode;$@\007"
}
iterm_both() { set_iterm_name 0 $@; }
iterm_tab() { set_iterm_name 1 $@; }
iterm_window() { set_iterm_name 2 $@; }

# for git
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
#     source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
#     source $(brew --prefix)/etc/bash_completion.d/docker
#     source $(brew --prefix)/etc/bash_completion.d/git-flow-completion.bash
# fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
#if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#__GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
#source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
#fi

function iterm2_print_user_vars() {
  iterm2_set_user_var gitStatus "$(getGitStatus)"
  iterm2_set_user_var tfWkspc "$(tfWkspc)"
}

function getGitStatus {
  if [[ $(git status 2>/dev/null) = "" ]]; then
    echo "$(topDir)"
  else
    echo "$(getGitProjectDir)$(topDir) git:($(getGitBranch))$(isGitBranchDirty)"
  fi
}

function getGitProjectDir {
  basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null
}

function topDir {
  if [[ $(basename $(pwd)) = $(getGitProjectDir) ]]; then
    echo ""
  else
    echo "/$(basename $(pwd))"
  fi
}

function getGitBranch {
  basename $(git branch 2>/dev/null | grep \* | cut -c3-) 2>/dev/null
}

function isGitBranchDirty {
  [[ $(git diff --shortstat 2>/dev/null | tail -n1) != "" ]] && echo "⚡ "
}

function tfWkspc {
  if [[ -n $proxy_host ]]; then
    terraform workspace list | grep '*' | cut -d " " -f 2
  else
    echo "no_proxy_set"
  fi
}

## export ENV settings
export LSCOLORS="EHfxcxdxBxegecabagacad"
export EDITOR=/usr/local/bin/code
export BLOCKSIZE=1k
#export PS1="\e]2;\u@\h:\w\a\e]1;\W\a\[\e[33m\]\d \t \[\e[38;5;14m\]\u@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\w\n\[\e[m\]\[\e[33;40m\]\[\e[m\]\\$ "
export PS1='\e]2;\u@\h:\w\a\e]1;\W\a\[\e[33m\]\d \t \[\e[38;5;14m\]\u@\[\e[35m\]\h\[\e[m\]:\[\e[32m\]\w\033[31m$(__git_ps1)\033[00m\n\[\e[m\]\[\e[33;40m\]\[\e[m\]\\$ '
export NVM_DIR="$HOME/.nvm"
export SSO_ID='212616315'
export VAULT_ADDR="https://dwt-vault.cloud.corporate.ge.com:443"

# uncomment for external programs that need proxy access:
#export ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi
# brew outdated | parallel --keep-order brew fetch --deps && brew upgrade # for newer gnu parallel

# history settings go here
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL=erasedups:ignoreboth
export HISTIGNORE='brew update:ls:[bf]g:history:exit:ll:pwd:clear:mount:rm *'
export HISTFILE=~/.bash_eternal_history
export HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s cmdhist
shopt -s histverify

# adobe air settings
#export AIR_HOME=

# make sure ssh-agent has our keys
export MYPUBKEY="/Users/212616315/.ssh/id_rsa"
ssh-add -ql | grep "$(ssh-keygen -qlf ${MYPUBKEY} | awk '{print $2}')"
# || if ! pgrep -q ssh-add; then timeout 10 ssh-add ${MYPUBKEY}; fi
# ssh-add -l &>/dev/null
if [ "$?" == 1 ]; then
  ssh-add ${MYPUBKEY}
#   # removing 20180418 errors loading key - keylength
#   #ssh-add ~/.ssh/azure.private.azure1.pem
fi
# ssh-add -l &>/dev/null
# if [ "$?" == 2 ]; then
#   echo "There is no ssh-agent running"
# fi
# adding this to make sure I don't accidentally exit macOS sessions
exit() {
  read -t5 -n1 -p "Do you really wish to exit? [yN] " should_exit || should_exit=y
  case $should_exit in
  [Yy]) builtin exit $1 ;;
  *) printf "\n" ;;
  esac
}

if $Interactive == 'true'; then
  PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
  export PATH=$PATH:/Users/$USER/bin

  test -e "${HOME}/.iterm2_shell_integration.bash" && "${HOME}/.iterm2_shell_integration.bash"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

  source ~/.scripts/tabFunc.sh
  #source '/Users/$USER/lib/azure-cli/az.completion'
  source /Users/$USER/lib/toggleproxy.sh
  # for file in $(find /Users/$USER/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions -type f -name geix*); do
  #   source $file
  # done
  # source /Users/$USER/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions/togglegeix
fi #end if $Interactive == 'true'

# The next lines enable bash completion for scalr-ctl.
# export PATH=$PATH:/Users/$USER/Library/Python/2.7/bin
# eval "$(_SCALR_CTL_COMPLETE=source scalr-ctl)"
# enabling brew installed completions
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      echo "$COMPLETION starting:"
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi
complete -C /usr/local/Cellar/tfenv/$(tfenv --version | cut -d ' ' -f '2')/versions/$(tfenv version-name)/terraform terraform

##
# Your previous /Users/212616315/.bash_profile file was backed up as /Users/212616315/.bash_profile.macports-saved_2023-06-15_at_09:28:38
##

# MacPorts Installer addition on 2023-06-15_at_09:28:38: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/212616315/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# add krew to path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# echo "exiting bash_profile"

# Created by `pipx` on 2024-10-08 13:46:50
export PATH="$PATH:/Users/212616315/.local/bin"

complete -C /usr/local/bin/vault vault
