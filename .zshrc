# echo "entering .zshrc"
export zshrc=true
eval "$(brew shellenv)"
# autoload -Uz compinit compinit
source /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# make sure ssh-agent has our keys
export MYPUBKEY="/Users/212616315/.ssh/id_rsa"
ssh-add -ql | grep "$(ssh-keygen -qlf ${MYPUBKEY} | awk '{print $2}')"

if [[ -o interactive ]]; then
  cowsay $(fortune)
  eval "$(thefuck --alias)"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


autoload -Uz compinit compinit
# figure out if we are in an interactive shell for use later
[[ $- == *i* ]] && Interactive='true' || Interactive='false'

HISTSIZE=50000
SAVEHIST=120000

setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt CORRECT


#   # Kubernetes
#   #      set editor for kubectl
#   export KUBE_EDITOR='code --wait'

#   # Homebrew
#   # export HOMEBREW_UPGRADE_CLEANUP=1

#   # rbenv
#   eval "$(rbenv init -)"

# # virtualenv
# # set -x
# # export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# # export WORKON_HOME=~/virtualenvs
# # export PROJECT_HOME=~/git/cloud
# # source /usr/local/bin/virtualenvwrapper.sh
# # alias noenv='deactivate'
# # autoenv
# # source /usr/local/opt/autoenv/activate.sh
# # set +x
# fi #end if $Interactive == 'true'

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

source ~/.exports

source ~/.aliases
# brew outdated | parallel --keep-order brew fetch --deps && brew upgrade # for newer gnu parallel

# history settings go here
source ~/.history

# adobe air settings
#export AIR_HOME=

# || if ! pgrep -q ssh-add; then timeout 10 ssh-add ${MYPUBKEY}; fi
# ssh-add -l &>/dev/null
# if [ "$?" == 1 ]; then
#   ssh-add ${MYPUBKEY}
# #   # removing 20180418 errors loading key - keylength
# #   #ssh-add ~/.ssh/azure.private.azure1.pem
# fi
# ssh-add -l &>/dev/null
# if [ "$?" == 2 ]; then
#   echo "There is no ssh-agent running"
# fi

# adding this to make sure I don't accidentally exit macOS sessions
# exit() {
#   read -t5 -n1 -p "Do you really wish to exit? [yN] " should_exit || should_exit=y
#   case $should_exit in
#   [Yy]) builtin exit $1 ;;
#   *) printf "\n" ;;
#   esac
# }

# if $Interactive == 'true'; then
#   PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#   export PATH=$PATH:/Users/$USER/bin

#   test -e "${HOME}/.iterm2_shell_integration.bash" && "${HOME}/.iterm2_shell_integration.bash"
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

#   source ~/.scripts/tabFunc.sh
#   #source '/Users/$USER/lib/azure-cli/az.completion'
#   source /Users/$USER/lib/toggleproxy.sh
#   # for file in $(find /Users/$USER/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions -type f -name geix*); do
#   #   source $file
#   # done
#   # source /Users/$USER/git/cloud/DWT-DevOps/tools/terminal-tools/bash_profile/functions/togglegeix
# fi #end if $Interactive == 'true'

# # The next lines enable bash completion for scalr-ctl.
# # export PATH=$PATH:/Users/$USER/Library/Python/2.7/bin
# # eval "$(_SCALR_CTL_COMPLETE=source scalr-ctl)"
# # enabling brew installed completions
# if type brew &>/dev/null; then
#   HOMEBREW_PREFIX="$(brew --prefix)"
#   if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
#     source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#   else
#     for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
#       echo "$COMPLETION starting:"
#       [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
#     done
#   fi
# fi
# complete -C /usr/local/Cellar/tfenv/$(tfenv --version | cut -d ' ' -f '2')/versions/$(tfenv version-name)/terraform terraform

# ##
# # Your previous /Users/212616315/.bash_profile file was backed up as /Users/212616315/.bash_profile.macports-saved_2023-06-15_at_09:28:38
# ##

source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh --config ~/.mytheme.omp.json)"
# fi

# activate mise: https://mise.jdx.dev/
eval "$(mise activate zsh)"

# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# setting up zsh autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# you should use (your own aliases)
source /usr/local/share/zsh-you-should-use/you-should-use.plugin.zsh

# Set up fzf key bindings and fuzzy completion
# https://github.com/junegunn/fzf#setting-up-shell-integration
source <(fzf --zsh)
bindkey "ç" fzf-cd-widget

# echo "exiting zshrc"

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/vault vault
