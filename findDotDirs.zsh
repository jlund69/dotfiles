echo '*** dotDirs in user directory ***'
fd '^\.' -t d --hidden --exclude '.*/*' --exclude 'Library/*' --exclude 'Documents/*' --exclude 'Movies/*' --exclude '/Music/*' --exclude 'Pictures/*' --exclude 'oldmac_data/*' --exclude 'git/*' --exclude 'Downloads/*' --exclude 'go/*' --exclude '**/.DS_Store' --exclude '**/.localized' --exclude '**/.gitignore' ~
