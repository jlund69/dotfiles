# export FD_EXCLUDES="--exclude '.*/*' --exclude 'Library/*' --exclude 'Documents/*' --exclude 'Movies/*' --exclude '/Music/*' --exclude 'Pictures/*' --exclude 'oldmac_data/*' --exclude 'git/*' --exclude 'Downloads/*' --exclude 'go/*' --exclude '**/.DS_Store' --exclude '**/.localized' --exclude '**/.gitignore'"

echo '**** links to dotfiles in user directory ***'
fd '^\.' --type symlink --hidden --exclude '.*/*' --exclude 'Library/*' --exclude 'Documents/*' --exclude 'Movies/*' --exclude '/Music/*' --exclude 'Pictures/*' --exclude 'oldmac_data/*' --exclude 'git/*' --exclude 'Downloads/*' --exclude 'go/*' --exclude '**/.DS_Store' --exclude '**/.localized' --exclude '**/.gitignore' ~

echo '*** dotfiles in user directory ***'
fd '^\.' -t f --hidden --exclude '.*/*' --exclude 'Library/*' --exclude 'Documents/*' --exclude 'Movies/*' --exclude '/Music/*' --exclude 'Pictures/*' --exclude 'oldmac_data/*' --exclude 'git/*' --exclude 'Downloads/*' --exclude 'go/*' --exclude '**/.DS_Store' --exclude '**/.localized' --exclude '**/.gitignore' ~
