# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing

plugins=(git zsh-autosuggestions zsh-syntax-highlighting bazel poetry zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration
#
# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# 10ms for key sequences
KEYTIMEOUT=1

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls=eza
alias ps=procs

# cat & man
alias cat=bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# rust
source $HOME/.cargo/env
eval "$(zoxide init --cmd j zsh)"

# starship prompt
eval "$(starship init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ccache
# export CC=/usr/lib/ccache/gcc
# export CXX=/usr/lib/ccache/g++
# export PATH="$PATH:/usr/lib/ccache"

export CXXFLAGS="-B/usr/local/libexec/mold"

export PATH="$PATH:$HOME/.local/bin"

# clang-format
alias clang-format='/usr/bin/clang-format-18'

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"

# node
export PATH="$PATH:$HOME/.deno/bin"

# git hook
export ENABLE_GIT_COMMIT_MSG_HOOK_INTERACTIVE=auto

alias grbi="git rebase -i --autosquash"
alias gwl="git worktree list"
alias gwrm="git worktree remove "

alias caps="setxkbmap -option ctrl:nocaps && xcape -e 'Control_L=Escape'"

# lua
export LUA_PATH='/home/alfonso.ros/.luarocks/share/lua/5.3/?.lua;/home/alfonso.ros/.luarocks/share/lua/5.3/?/init.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;$HOME/.luarocks/share/lua/5.3/?.lua;$HOME/.luarocks/share/lua/5.3/?/init.lua;/usr/local/lib/lua/5.3/?.lua;/usr/local/lib/lua/5.3/?/init.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;./?.lua;./?/init.lua'
export LUA_CPATH='/home/alfonso.ros/.luarocks/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/?.so;$HOME/.luarocks/lib/lua/5.3/?.so;/usr/lib/x86_64-linux-gnu/lua/5.3/?.so;/usr/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/loadall.so;./?.so'
export PATH="$PATH:$HOME/.luarocks/bin"
alias luamake=/home/alfonso.ros/gh/lua-language-server/3rd/luamake/luamake

# zig
export PATH="$PATH:$HOME/zig/0.12.0/"

# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.11.10/bin/python"

# 1password
eval "$(op completion zsh)"; compdef _op op
source /home/alfonso.ros/.config/op/plugins.sh

# apex repo
alias repo.check='bazel run --noshow_progress --ui_event_filters=-info --run_under="cd $(pwd) &&" //tools/repo:repo.check --'
alias repo.fix='bazel run --noshow_progress --ui_event_filters=-info --run_under="cd $(pwd) &&" //tools/repo:repo.fix --'
alias repo.sca='bazel run --noshow_progress --ui_event_filters=-info //apex_internal/tools/sca_check --'
alias identify_test_uid='bazel run --noshow_progress --ui_event_filters=-info  --run_under="cd $(pwd) &&"  //tools/identify_test_uid:main --'
alias apex_doc='bazel run --noshow_progress --ui_event_filters=-info --run_under="cd $(pwd) &&" //apex_internal/tools/apex_doc_tools:apex_doc --'

alias cleancache='find "$HOME/.cache/bazel" -type f -atime "+100" -delete >/dev/null 2>/dev/null'
alias cleanshm="rm -rf /dev/shm/*.data_segment; rm -rf /dev/shm/*.connection; rm -rf /tmp/*.listener; rm /tmp/apex_ida_resource_creator_uds"

# haskell
[ -f "/home/alfonso.ros/.ghcup/env" ] && . "/home/alfonso.ros/.ghcup/env" # ghcup-env

# elixir
export PATH=$HOME/.elixir-install/installs/otp/27.1.2/bin:$PATH
export PATH=$HOME/.elixir-install/installs/elixir/1.17.3-otp-27/bin:$PATH

# fzf
export FZF_DEFAULT_SORT=1000000
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
