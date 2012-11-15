# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# setting TERM based on COLORTERM
case $COLORTERM in
Terminal) export TERM=xterm-color ;;         # this is XFCE Terminal
gnome-terminal) export TERM=xterm-color ;;   # this is gnome-terminal
wterm-xpm) export TERM=xterm ;;              # this is wterm
Eterm) export TERM=Eterm ;;                  # this is Eterm
1) export TERM=xterm-color ;;                # this is lxterminal, konsole, yakuake, uxterm, Mac OSX terminal, putty ...
# rxvt) ;;                                   # xterm, aterm, rxvt-unicode
esac

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
[ -f ~/bin/git-completion.bash ] && . ~/bin/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=true
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\$ '
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR=vi
export HISTFILE=~/.history/all.hist
export HISTSIZE=1000000
export PATH=$PATH:/var/lib/gems/1.8/bin:/home/chrismay/bin
export JBOSS_HOME=/opt/jboss
export JBOSS_SERVER_BASE=~/jboss/server
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=512m  -Djava.security.egd=file:///dev/urandom"
#export MAVEN_OPTS="$MAVEN_OPTS  -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5004"
alias  pbcopy='xclip -selection clipboard'
alias  mat='cd /opt/MemoryAnalyzer; ./MemoryAnalyzer'

alias dev='cd ~/code/traf/dev'
alias serv='cd ~/code/traf/dev/services/logistics/service'
alias comp="cd ~/code/traf/dev/services/logistics/component-tests"
alias mdl='cd ~/code/traf/dev/mdl/logistics'
alias mdlp='cd ~/code/traf/dev/mdl/logistics/public/definitions/lib'
alias mdli='cd ~/code/traf/dev/mdl/logistics/internal/definitions/lib'

alias sqldev='nohup /opt/sqldeveloper/sqldeveloper/bin/sqldeveloper >/dev/null 2>&1 &'
alias rabbit-msg='tail -f ~/jboss/server/trafigura/log/server.log | ~/code/alfie/scripts/rabbit-events'
alias sqlplus="rlwrap sqlplus64"
alias sqlp="rlwrap sqlplus64 traf_logistics_dev20/traf_logistics_dev20@//titandbserver2:1521/traf2"

alias acg='cd ~/code/warwick/acg/acg'
alias act='cd ~/code/warwick/acg/acg-ac-tests'
alias mci="mvn clean install"
alias mbr='MAVEN_OPTS="$MAVEN_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5004" mvn clean bees:run -Dbees.environment=local'
alias mcts="mvn clean test -Dspring.profiles.active=default"
alias mcc="mvn cobertura:cobertura && firefox target/site/cobertura/index.html"
alias notes="gvim ~/Dropbox/working_notes.md"

alias asq="mysql -u acg -pacg acg"
export BEES_HOME=~/cloudbees-sdk-1.2.2
export PATH=$PATH:$BEES_HOME

