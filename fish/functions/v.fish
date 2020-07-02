# Defined in - @ line 0
function v --description 'alias v=vim (fzf --preview="bat --style=numbers --color=always --line-range :100 {}")'
	vim (fzf --preview="bat --style=numbers --color=always --line-range :100 {}") $argv;
end
