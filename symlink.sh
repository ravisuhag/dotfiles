# Symlink zsh file

DOTFILES_DIRECTORY="${HOME}/.dotfiles"


link() {
    # Force create/replace the symlink.
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

link "zsh/.zshrc" ".zshrc"
