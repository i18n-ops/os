declare -A ZINIT
export ZINIT_HOME=/opt/zinit/zinit.git
export ZINIT[HOME_DIR]=/opt/zinit
export ZPFX=/opt/zinit/polaris
source "$ZINIT_HOME/zinit.zsh"

run(){
[[ ! -f $1 ]] || source $1
}

run ~/.p10k.zsh

if [[ -r "~/.cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "~/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit light skywind3000/z.lua
_zlua_precmd() {
  ("/usr/local/bin/czmod" --add "${PWD:a}" &)
}

export FZ_HISTORY_CD_CMD=_zlua
zinit ice wait lucid
zinit light changyuheng/fz

zinit ice wait lucid
zinit light changyuheng/zsh-interactive-cd

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaaa,bg=black"
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

#HISTFILE=~/.zsh_history
#HISTSIZE=10000
#SAVEHIST=10000
#setopt SHARE_HISTORY
#zinit ice wait lucid
#zinit light zdharma-continuum/history-search-multi-word

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

eval "$(direnv hook zsh)"
setopt COMBINING_CHARS

