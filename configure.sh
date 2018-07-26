if which nvim
then
    plug_dir="~/.config/nvim/autoload"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall
else
    plug_dir="~/.vim/autoload"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs $plug_dir
    vim +PlugInstall
fi
