# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias e='cd /home/fepa/emacs-lib/ && ./oneframescript'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Show an asterix if git state is dirty
GIT_PS1_SHOWDIRTYSTATE=true

# My own terminal header
GREEN='\e[1;32m'
BLUE='\[\034[0;34m\]'
RESET='\[\e[0m\]'
PS1='\[\e[1;32m\]\u@\h\[\e[0;34m\]$(__git_ps1) \[\e[0m\]\$ '

# Settings for history function
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='\&:e:c:l:ca:cd:cd -'

# Make history work well with multiple shells
# append to the history file, don't overwrite it
shopt -s histappend

# Bind up/down arrow to history search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Start emacs server if it isn't running
# http://stackoverflow.com/a/5578718
export ALTERNATE_EDITOR=""

export TERM=xterm-256color

# Java/tomcat stuff :(
export JAVA_HOME=/usr/lib/jvm/default-java
export CATALINA_HOME=/usr/share/tomcat7


# Restore postgres backup
function pglocal {
	if [ "$1" = "" ]; then
		echo "Run like this:"
		echo "pglocal USER DATABASE PATH/TO/FILE"
	else
		pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $1 -d $2 $3
	fi
}

# Copy a postgres database
function pgcopy {
    if [ "$1" = "" ]; then
        echo "Run like this:"
        echo "pgcopy original_database name_of_copy_database"
    else
        ORIGINAL=$1
        COPY=$2
        echo "Creating database $COPY..."
        psql $ORIGINAL -c "create database $COPY"
        echo "Dumping original database to $ORIGINAL.dump"
        pg_dump -Fc $ORIGINAL > "$ORIGINAL.dump"
        echo "Restoring dump..."
        pg_restore -d $COPY "$ORIGINAL.dump"
        echo "Removing dumpfile..."
        rm "$ORIGINAL.dump"
        echo "Done!"
    fi
}
