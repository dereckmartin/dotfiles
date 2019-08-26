# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#if [ -n "$DISPLAY" ]; then
#    xscreensaver -no-splash &
#    nm-applet > /dev/null 2&>1 &
#fi

if [ $(ps aux | grep "ssh-agent \-s" | grep $(whoami) | wc -l) -gt 1 ]; then
  echo "...Cleaning up ssh-agent"
  killall ssh-agent
  for i in $(ls -l /$TMPDIR/ssh-*/agent.* 2> /dev/null | grep $(whoami)); do
    rm -f $i
  done
  echo "...Starting ssh-agent" 
  eval `ssh-agent -s` > /dev/null
elif [ $(ps aux | grep "ssh-agent \-s" | grep $(whoami) | wc -l) -eq 0 ]; then
  for i in $(ls -l /$TMPDIR/ssh-*/agent.* 2> /dev/null | grep $(whoami)); do
    rm -f $i
  done
  echo "...Starting ssh-agent"
  eval `ssh-agent -s` > /dev/null
  ssh-add ~/.ssh/id_rsa
fi

# set environment variables if user's agent already exists
[ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=$(ls -l /$TMPDIR/ssh-*/agent.* 2> /dev/null | grep $(whoami) | awk '{print $10}')
[ -z "$SSH_AGENT_PID" -a -z `echo $SSH_AUTH_SOCK | cut -d. -f2` ] && SSH_AGENT_PID=$((`echo $SSH_AUTH_SOCK | cut -d. -f2` + 1))
[ -n "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK
[ -n "$SSH_AGENT_PID" ] && export SSH_AGENT_PID

# start agent if necessary
#if [ -z $SSH_AGENT_PID ] && [ -z $SSH_TTY ]; then  # if no agent & not in ssh
#  eval `ssh-agent -s` > /dev/null
#  ssh-add ~/.ssh/id_rsa
#fi

# setup addition of keys when needed
if [ -z "$SSH_TTY" ] ; then                     # if not using ssh
  ssh-add -l > /dev/null                        # check for keys
  if [ $? -ne 0 ] ; then
    alias ssh='ssh-add -l > /dev/null || ssh-add && unalias ssh ; ssh'
    if [ -f "/usr/libexec/openssh/x11-ssh-askpass" ] ; then
      SSH_ASKPASS="/usr/libexec/openssh/x11-ssh-askpass" ; export SSH_ASKPASS
    fi
  fi
fi

#ssh-add ~/.ssh/id_rsa

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
