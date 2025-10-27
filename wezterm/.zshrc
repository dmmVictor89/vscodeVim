# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jinpyo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Get Winodw env
export PATH="$PATH:/c/Windows/System32"
export WINDIR=${WINDIR:-/c/Windows}
export USERPROFILE=${USERPROFILE:-/c/Users/$(whoami)}

# Set vi in readline
set -o vi

# bindkey -M vicmd: vi 위젯 확인
# # zle -l: zle 라인에딩터 위젯 확인

bindkey -M vicmd 'j' backward-char   # ← 원래 h
bindkey -M vicmd 'k' down-line-or-history   # ↓ 원래 j
bindkey -M vicmd 'l' up-line-or-history     # ↑ 원래 k
bindkey -M vicmd ';' forward-char  # → 원래 l
bindkey -M vicmd '\-' vi-end-of-line # 라인 끝으로 이동

# Default Path Setting
export PATH="$PATH:/c/MyProgramFiles/Neovim/bin/"
export PATH="$PATH:/c/MyProgramFiles/msys64/ucrt64/bin"
export PATH="$PATH:/c/MyProgramFiles/msys64/mingw64/bin"
export PATH="$PATH:/c/MyProgramFiles/nodejs/"
export PATH="$PATH:/c/Users/jinpyo/AppData/Roaming/npm"
export PATH="$PATH:/c/Windows/System32/OpenSSH/"
export PATH="$PATH:/c/MyProgramFiles/Java/jdk-11.0.1/bin"
export PATH="$PATH:/c/MyProgramFiles/Git/bin/"
export PATH="$PATH:/c/MyProgramFiles/Git/usr/bin/" # ssh-copy-id 사용시
export PATH="$PATH:/c/MyProgramFiles/Git/usr/bin/ssh.exe" # ssh-copy-id 사용시
export TMUX_CONF="/c/MyProgramFiles/msys64/home/jinpyo/"


# ZSH Starting
# plugin
source ~/.zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# theme
eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config '/home/jinpyo/.oh-my-zsh/theme/sorin.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/paradox.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/agnoster.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/pure.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/sorin.omp.json')"
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/powerline.omp.json')"

# 두 줄 쓰도록 설정
export PS2='$(oh-my-posh print secondary --shell=zsh)'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# prompt set
prompt_context() {}


# Plugin
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install
#
plugins=(
            zsh-autosuggestions
            zhs-syntax-highlighting
            fzf
       )



# Alias
alias vi="nvim"

alias ll='ls -lah'
alias lg='ll | grep'

alias vi='nvim'
alias vim='nvim'
# alias tmux="tmux -f $TMUX_CONF"
alias t='tmux'
alias cnv="cd /c/Users/jinpyo/AppData/Local/nvim/"
alias ctm="cd /c/Users/jinpyo/.tmux/plugins/tpm/bin"

export SSH_CONFIG=~/.ssh/config
alias ssh='ssh -F $SSH_CONFIG'
alias ..='cd .. && ll'
alias cws='cd /c/workspace'
alias ex='Explorer '
alias exd='Explorer .'

alias f=zi

# ----- 함수
fl(){
  cd "$1" && ll
}

klog(){
    /c/MyProgramFiles/klogg/klogg.exe "$1" &
}
