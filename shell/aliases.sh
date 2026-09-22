# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ls="eza --color=always --icons=always --group-directories-first"
alias l="ls -l --git"
alias la="ls -la --git"
alias tree="eza --color=always --icons=always --tree --group-directories-first --git-ignore"
alias rf="rm -rf"
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

# Git
alias g="git"
alias gaa="git add -A"
alias gapa="git add --patch"
alias gc="git commit -m"
alias gcl="git clone"
alias gca="git add --all && git commit --amend --no-edit"
alias gcam='git add --all && git commit -m'
alias gco="git checkout"
alias gcm="git checkout main"
alias gsw="git switch"
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gp="git push"
alias gpf="git push --force"
alias gpsup='git push --set-upstream origin $(git branch --show-current)'
alias gl="git pull --rebase --autostash"
alias gb="git branch"
alias gbD="git branch -D"
alias glog='$DOTLY_PATH/bin/dot git pretty-log'
alias gloga="git log --oneline --decorate --graph"

# Git: rebase
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grbm="git rebase main"

# Git: stash
alias gsta="git stash push"
alias gstp="git stash pop"
alias gstl="git stash list"
alias gstd="git stash drop"
alias gstcl="git stash clear"

# Git: restore / reset
alias grs='git restore --staged --worktree .'
alias grst="git restore --staged"
alias grsf='git restore . && git clean -fd'
alias groh='git reset "origin/$(git branch --show-current)" --hard'
alias gundo="git reset --soft HEAD~1"

# Git: WIP
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip--"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q -- "--wip--" && git reset HEAD~1'

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias v.='(code $PWD &>/dev/null &)'
alias c.='(cursor $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'

alias cc="claude --chrome"
alias oc="OPENCODE_CONFIG_CONTENT='{\"permission\":\"allow\"}' opencode"

alias nr="npm run"