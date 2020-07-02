# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/navin/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
conda activate misc

# fzf
export FZF_DEFAULT_COMMAND="fd -t f "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND . $HOME"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_ALT_C_OPTS="--preview 'tree {}'"
export FZF_TMUX_HEIGHT="80%"


# skim
export SKIM_DEFAULT_COMMAND="fd -t f"
export SKIM_ALT_C_COMMAND="cd (fd -t d . $HOME | sk)"

# Notes
export NOTES_DIR="/home/navin/workspace/books/youtube-notes/src/"
