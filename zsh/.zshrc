setopt AUTO_PARAM_SLASH 
unsetopt CASE_GLOB

autoload -Uz compinit; compinit
# Autocomplete hidden files
_comp_options+=(globdots)
source ~/dotfiles/zsh/external/completion.zsh

fpath=($ZDOTDIR/external $fpath)

autoload -Uz prompt_purification_setup; prompt_purification_setup
autoload -Uz cursor_mode && cursor_mode

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack.
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using pushd or popd.
setopt PUSHD_SILENT

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$XDG_CONFIG_HOME/zsh/external/bd.zsh"

if [ $(command -v "fzf") ]; then
   source /usr/share/fzf/completion.zsh
   source /usr/share/fzf/key-bindings.zsh
fi

source "$XDG_CONFIG_HOME/zsh/external/zsh-autosuggestions.zsh"

source "$XDG_CONFIG_HOME/zsh/aliases"

if [ "$(tty)" = "/dev/tty1" ];
then
  pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi


# colemak vi
bindkey -v
bindkey -a 't' vi-insert
bindkey -a 'T' vi-insert-bol
bindkey -a 'u' vi-undo-change
bindkey -a 'J' vi-join

export KEYTIMEOUT=1

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.symfony5/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/insomnia:$PATH"



# pnpm
export PNPM_HOME="/home/yas/.config/local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
