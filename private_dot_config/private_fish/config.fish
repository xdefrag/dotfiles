if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH $PATH:/opt/homebrew/bin
set -gx EDITOR nvim

alias v nvim
alias vim nvim
alias gst "git status"
alias gd "git diff"
alias gdc "git diff --cached"
alias gp "git push"
alias gpf "git push --force"
alias gri "git rebase --interactive"
alias gc "git commit -S"
alias gcm "git commit -S -m"
alias gca "git commit --amend"
alias ga "git add"
alias gaa "git add ."
