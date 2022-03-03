export BASH_SILENCE_DEPRECATION_WARNING=1
# figure out if we are in an interactive shell for use later
[[ $- == *i* ]] && Interactive='true' || Interactive='false'

if $Interactive == 'true'; then
cowsay $(fortune -a)
eval "$(thefuck --alias)"

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
  mode=$1; shift
  echo -ne "\033]$mode;$@\007"
}
iterm_both () { set_iterm_name 0 $@; }
iterm_tab () { set_iterm_name 1 $@; }
iterm_window () { set_iterm_name 2 $@; }

# for git
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
    source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
    source $(brew --prefix)/etc/bash_completion.d/docker
    source $(brew --prefix)/etc/bash_completion.d/git-flow-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
#if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#__GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
#source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
#fi

function iterm2_print_user_vars() {
  iterm2_set_user_var gitStatus "$(getGitStatus)"
}

function getGitStatus {
  if [[ $(git status 2> /dev/null) = "" ]]; then
    echo "$(topDir)"
  else
    echo "$(getGitProjectDir)$(topDir) git:($(getGitBranch))$(isGitBranchDirty)"
  fi
}

function getGitProjectDir {
  basename $(git rev-parse --show-toplevel 2> /dev/null ) 2> /dev/null
}

function topDir {
  if [[ $(basename $(pwd)) = $(getGitProjectDir) ]]; then
   echo ""
  else
   echo "/$(basename $(pwd))"
  fi
}

function getGitBranch {
  basename $(git branch 2> /dev/null | grep \* | cut -c3-) 2> /dev/null
}

function isGitBranchDirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "⚡ "
}

## export ENV settings
export LSCOLORS="EHfxcxdxBxegecabagacad"
export EDITOR=/usr/local/bin/vim
export BLOCKSIZE=1k
#export PS1="\e]2;\u@\h:\w\a\e]1;\W\a\[\e[33m\]\d \t \[\e[38;5;14m\]\u@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\w\n\[\e[m\]\[\e[33;40m\]\[\e[m\]\\$ "
export PS1='\e]2;\u@\h:\w\a\e]1;\W\a\[\e[33m\]\d \t \[\e[38;5;14m\]\u@\[\e[35m\]\h\[\e[m\]:\[\e[32m\]\w\033[31m$(__git_ps1)\033[00m\n\[\e[m\]\[\e[33;40m\]\[\e[m\]\\$ '
export NVM_DIR="$HOME/.nvm"
export SSO_ID='212616315'
export VAULT_ADDR="https://dwt-vault.cloud.corporate.ge.com:443"

# uncomment for external programs that need proxy access:
#export ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias ~="cd ~"                              # ~:            Go Home
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias ls='ls -G'

# aliases go here
alias aws='/Users/johnlund/Library/Python/3.6/bin/aws'
alias ll='ls -FGlAhp'
alias mkdir='mkdir -pv'
alias less='less -FSRXc'
# alias brew='ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80 brew'
alias rd='rdesktop -r scard -g 1280x800 -a 16 -z -P'
alias myrs='rsync -varE --progress'
alias addsbin='export PATH="/usr/local/sbin:$PATH"'
alias usego='export PATH="$PATH:/usr/local/opt/go/libexec/bin"'
alias useopenssl='export PATH="/usr/local/opt/openssl/bin:$PATH"'
alias usecode='PATH="
$PATH:~/Applications/Visual Studio Code.app/Contents/Resources/app/bin"'
alias myproxy='ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
alias httpproxy='http_proxy=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
#alias sftp='with-readline sftp'
alias tac='gtac'
alias cdp='pushd'
alias vault-login="vault login -method=ldap username=$GE_SSO_ID"
alias ws='/Applications/Wireshark.app/Contents/MacOS/wireshark'
alias wireshark='/Applications/Wireshark.app/Contents/MacOS/wireshark'

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

# make sure ssh-agent has our keys
ssh-add -l &> /dev/null
if [ "$?" == 1 ]; then
    ssh-add ~/.ssh/id_rsa
    # removing 20180418 errors loading key - keylength
    #ssh-add ~/.ssh/azure.private.azure1.pem
fi
ssh-add -l &> /dev/null
if [ "$?" == 2 ];then
    echo "There is no ssh-agent running"
fi

# adding this to make sure I don't accidentally exit macOS sessions
exit() {
    read -t5 -n1 -p "Do you really wish to exit? [yN] " should_exit || should_exit=y
    case $should_exit in
        [Yy] ) builtin exit $1 ;;
        * ) printf "\n" ;;
    esac
}


if $Interactive == 'true'; then
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export PATH=$PATH:/Users/johnlund/bin

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.scripts/tabFunc.sh
#source '/Users/johnlund/lib/azure-cli/az.completion'
source /Users/johnlund/lib/toggleproxy.sh
for file in `find /Users/johnlund/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions -type f -name geix*`
do
  source $file
done
source /Users/johnlund/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions/togglegeix
fi #end if $Interactive == 'true'

# The next lines enable bash completion for scalr-ctl.
export PATH=$PATH:/Users/johnlund/Library/Python/2.7/bin
eval "$(_SCALR_CTL_COMPLETE=source scalr-ctl)"
