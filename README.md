Setup dotfiles alias
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Clone repositoriy
```
git clone --bare https://github.com/dereckmartin/dotfiles.git $HOME/.dotfiles
```

Backup old files that will conflict.
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

Checkout dotfiles into $HOME
```
dotfiles checkout
```

Use diff to see what changes need to be migrated to your new files.
```
diff -urN .config-backup/.bashrc .bashrc > bashrc.patch
```

When adding or changing a dotfile in ${HOME}
```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Updated .vimrc"
dotfiles push -u origin master
```

Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
