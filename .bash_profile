cowsay $(fortune -a)
eval "$(thefuck --alias)"

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

## export ENV settings
export EDITOR=usr/bin/vim
export BLOCKSIZE=1k
export PS1="\e]2;\u@\h:\w\a\e]1;\W\a\[\e[33m\]\d \t \[\e[38;5;14m\]\u@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\w\n\[\e[m\]\[\e[33;40m\]\[\e[m\]\\$ "
export NVM_DIR="$HOME/.nvm"

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
alias ll='ls -FGlAhp'
alias mkdir='mkdir -pv'
alias less='less -FSRXc'
alias brew='ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80 brew'
alias rd='rdesktop -r scard -g 1280x800 -a 16 -z -P'
alias myrs='rsync -varE --progress'
alias usego='export PATH="$PATH:/usr/local/opt/go/libexec/bin"'
alias useopenssl='export PATH="/usr/local/opt/openssl/bin:$PATH"'
alias myproxy='ALL_PROXY=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
alias httpproxy='http_proxy=http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
#alias sftp='with-readline sftp'
alias tac='gtac'
alias cdp='pushd'

# history settings go here
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='rm *:ls:[bf]g:history:exit:ll:pwd:clear:mount'
export HISTFILE=~/.bash_eternal_history
shopt -s histappend
shopt -s cmdhist
shopt -s histverify

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.scripts/tabFunc.sh

# make sure ssh-agent has our keys
ssh-add -l &> /dev/null
if [ "$?" == 1 ]; then
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/azure.private.azure1.pem
fi
ssh-add -l &> /dev/null
if [ "$?" == 2 ];then
    echo "There is no ssh-agent running"
fi

# virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
alias noenv='deactivate'
# autoenv
source /usr/local/opt/autoenv/activate.sh

# adding this to make sure I don't accidentally exit macOS sessions
exit() {
    read -t5 -n1 -p "Do you really wish to exit? [yN] " should_exit || should_exit=y
    case $should_exit in
        [Yy] ) builtin exit $1 ;;
        * ) printf "\n" ;;
    esac
}

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PATH=$PATH:/Users/johnlund/bin

source '/Users/johnlund/lib/azure-cli/az.completion'
