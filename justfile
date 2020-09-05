d:=invocation_directory()
commit_file:="~/Projects/commit.md"
editor:="nvim"

alias e:=edit
alias st:=status
alias cm:=commit
alias pl:=pull
alias ps:=push
alias psf:=push_force
alias c:=clone
alias su:=set_upstream
alias gb:=branch
alias pr:=pull-request

list:
    @just --list

edit FILE:
    cd {{d}} && {{editor}} {{FILE}}

ec:
    {{editor}} {{commit_file}}

status:
    cd {{d}} && git status

add:
    cd {{d}} && git add .

commit: status
    cd {{d}} && git diff --quiet && git diff --staged --quiet || git commit -F {{commit_file}}

amend: status
    cd {{d}} && git diff --quiet && git diff --staged --quiet || git commit --amend -F {{commit_file}}

pull: commit
    cd {{d}} && if git config remote.upstream.url > /dev/null; then git pull --rebase upstream master; fi

push: pull
    cd {{d}} && git push origin HEAD

push_force: pull
    cd {{d}} && git push -f origin HEAD

clone REPO:
    cd {{d}} && hub clone {{REPO}}

set_upstream LINK:
    cd {{d}} && git remote add upstream {{LINK}}

branch BRANCH:
    cd {{d}} && git checkout -B {{BRANCH}}

pull-request: push_force
    cd {{d}} && hub pull-request --no-edit

run:
    #!/usr/bin/env sh
    cd {{d}}
    if [ -f run ]; then
        ./run
    else
        echo "No run script found!"
    fi
