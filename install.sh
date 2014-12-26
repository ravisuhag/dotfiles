echo 'Installing dotfiles by Ravi Suhag'

home="${HOME}"

cd ${home}

echo "Cloning dotfile repository ..."
git clone git://github.com/ravisuhag/dotfiles.git  .dotfiles

cd .dotfiles
echo "Symlinking files ..."
bash symlink.sh

