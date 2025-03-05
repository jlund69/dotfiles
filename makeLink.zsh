export DOTFILEDIR="/Users/212616315/git/github/jlund69/dotfiles"
if [[ -f $DOTFILEDIR/$1 ]] && [[ $(diff $1 $DOTFILEDIR/$1) ]]; then
  echo "updating by copying $1 to dotfiles"
  cp $1 $DOTFILEDIR/.
  mv $1 $1.bak
  ln -s $DOTFILEDIR/$1 $1
else
  echo "the files are the same OR the dotfile version DNE"
  if [[ ! -f $DOTFILEDIR/$1 ]]; then
    echo "the dotfile version DNE, lets create it"
    cp $1 $DOTFILEDIR/.
  elif [[ -L $1 ]]; then
    echo "this is already a symlink, so we'll do nada"
    return 0
  fi
  mv $1 $1.bak
  ln -s $DOTFILEDIR/$1 $1
fi
