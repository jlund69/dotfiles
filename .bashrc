echo "entering .bashrc"
if ! ${bp} == true; then
  source ~/.bash_profile
fi
# eval "$(frum init)"
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/212616315/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
eval "$(mise activate bash)"                    # hooking mise into bash
export PATH="$PATH:/Users/212616315/.local/bin" # Added by Docker Labs Debug Tools"
echo "exiting .bashrc"
