# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export VAGRANT_DEFAULT_PROVIDER=virtualbox

function vibash () {
    /usr/bin/vim $HOME/.bashrc && { 
        rebash
    }
}

function rebash () {
    source $HOME/.bashrc
}

alias dotfiles='/usr/bin/git --git-dir=/home/dmartin/.dotfiles --work-tree=/home/dmartin'
