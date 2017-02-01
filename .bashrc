# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export VAGRANT_DEFAULT_PROVIDER=virtualbox

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

#
# setup ssh-agent
#

##
 # Dotfiles repository
alias dotfiles='/usr/bin/git --git-dir=/home/dmartin/.dotfiles --work-tree=/home/dmartin'
