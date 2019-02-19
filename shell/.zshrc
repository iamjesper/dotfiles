export LANG="en_US.UTF-8"
export EDITOR=nvim
export NVM_AUTO_USE=true
source ~/.aliases
bindkey '^ ' autosuggest-accept

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --hidden --type f -E .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden --type d -E .git"
export FZF_DEFAULT_OPTS='
  --color=bg+:10,bg:0,spinner:6,hl:4
  --color=fg:12,header:4,info:3,pointer:6
  --color=marker:6,fg+:13,prompt:3,hl+:4'

# zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "lukechilds/zsh-nvm"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
if ! zplug check; then
  zplug install
fi
zplug load

# pure prompt
autoload -U promptinit; promptinit
prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"
PURE_PROMPT_SYMBOL='→'

vicd()
{
  local dst="$(command vifm --choose-dir - "$@")"
  if [ -z "$dst" ]; then
    echo 'Directory picking cancelled/failed'
    return 1
  fi
  cd "$dst"
}
