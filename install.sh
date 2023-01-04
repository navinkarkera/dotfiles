#!/bin/bash

if [[ -z $HOME/dotfiles ]]; then
	cd $HOME && git clone git@gitlab.com:navinkarkera/dotfiles.git
fi
sudo pacman -Syy --needed neovim tmux alacritty stow paru zsh bat fd ripgrep exa fzf broot zoxide xsel btop ttf-firacode-nerd lazygit git-delta glow
paru -S --needed smug go-jira-bin nvm nerd-fonts-anonymous-pro tmux-plugin-manager-git

cd $HOME/dotfiles
stow alacritty nvim tmux zsh shell project-scripts xprofile i3 fontconfig git smug jira glow
# chsh -s $(which zsh)
mkdir -p ~/.local/share/fonts ~/.local/share/gnupg ~/.cache/zsh
cd ~/.local/share/fonts && curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Regular/complete/Code%20New%20Roman%20Nerd%20Font%20Complete.otf -fLo "Code New Roman Nerd Font Complete.otf"
