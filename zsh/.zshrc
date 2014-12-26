DOTFILES_DIRECTORY="${HOME}/.dotfiles"


source ${DOTFILES_DIRECTORY}/zsh/colors.zsh
source ${DOTFILES_DIRECTORY}/zsh/setopt.zsh
source ${DOTFILES_DIRECTORY}/zsh/exports.zsh
source ${DOTFILES_DIRECTORY}/zsh/prompt.zsh
source ${DOTFILES_DIRECTORY}/zsh/completion.zsh
source ${DOTFILES_DIRECTORY}/zsh/aliases.zsh
source ${DOTFILES_DIRECTORY}/zsh/bindkeys.zsh
source ${DOTFILES_DIRECTORY}/zsh/functions.zsh
source ${DOTFILES_DIRECTORY}/zsh/history.zsh
source ${DOTFILES_DIRECTORY}/zsh/zsh_hooks.zsh
source ${DOTFILES_DIRECTORY}/zsh/hitch.zsh


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

precmd() {
  if [[ -n "$TMUX" ]]; then
    tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
  fi
}
