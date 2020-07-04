# Defined in - @ line 0
function se --description 'alias se=vim (fd -t f . ~/.config ~/Projects/scripts | fzf --preview="bat --style=numbers --color=always --line-range :100 {}")'
	vim (fd -t f . ~/.config ~/Projects/scripts | fzf --preview="bat --style=numbers --color=always --line-range :100 {}") $argv;
end
