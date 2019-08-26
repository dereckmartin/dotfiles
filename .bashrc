# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

##
 # Edit bashrc and reload.
 #
function vibash () {
    /usr/bin/vim $HOME/.bashrc && { 
        rebash
    }
}

##
 # Reload bashrc.
 #
function rebash () {
    source $HOME/.bashrc
}

##
 # Dotfiles repository
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'

##
 # Additional Includes
 #

for f in ~/.lib/*; do 
  source $f; 
done
