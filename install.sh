#!/bin/bash

if [[ -z $HOME/dotfiles ]]; then
	cd $HOME && git clone git@gitlab.com:navinkarkera/dotfiles.git
fi
sudo pacman -Syy --needed neovim tmux alacritty stow paru zsh bat fd ripgrep exa fzf zoxide xsel btop lazygit git-delta glow nitrogen pass xdotool timew bc ttf-ibmplex-mono-nerd dunst at ttf-jetbrains-mono picom
paru -S --needed go-jira-bin nvm tmux-plugin-manager git-extras python-timew-report python-pyfzf

cd $HOME/dotfiles
stow alacritty nvim tmux zsh shell project-scripts xprofile i3 fontconfig git jira glow pueue dunst timewarrior
# chsh -s $(which zsh)
mkdir -p ~/.local/share/fonts ~/.local/share/gnupg ~/.cache/zsh
# cd ~/.local/share/fonts && curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Regular/complete/Code%20New%20Roman%20Nerd%20Font%20Complete.otf -fLo "Code New Roman Nerd Font Complete.otf"
