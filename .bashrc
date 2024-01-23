export EDITOR="vim"
export HISTSIZE=5000
# Enable timestamps for history
export HISTTIMEFORMAT="%FT%T%z "
# To sync history across sessions
export PROMPT_COMMAND="history -a; history -c; history -r"

export XDG_CONFIG_HOME="$HOME/.config"

if command -v exa &> /dev/null
then
  alias ll='exa --long --group --header --group-directories-first'
  alias la='exa --long --group --header --group-directories-first --all'
fi

if command -v nvim &> /dev/null
then
  alias vim="nvim"
fi

alias ssh-dev-env="ssh -o StrictHostKeyChecking=no -o \"UserKnownHostsFile /dev/null\""
alias sftp-dev-env="sftp -o StrictHostKeyChecking=no -o \"UserKnownHostsFile /dev/null\""
alias vimdiff='vim -d'
alias alertme="echo -e \"\\a\""

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

