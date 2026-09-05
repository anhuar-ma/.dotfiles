# ~/.config/fish/conf.d/30-abbreviations.fish
# Interactive abbreviations expand in-place, so history contains the real command.
# They are preferred over aliases for typing speed and never affect scripts.

status is-interactive; or return

# --- Git ---------------------------------------------------------------
abbr -a g    git
abbr -a gs   'git status'
abbr -a gd   'git diff'
abbr -a gds  'git diff --staged'
abbr -a ga   'git add'
abbr -a gap  'git add --patch'
abbr -a gb   'git branch'
abbr -a gsw  'git switch'
abbr -a gco  'git checkout'
abbr -a gcb  'git checkout -b'
abbr -a gcm  'git commit -m'
abbr -a gca  'git commit --amend --no-edit'
abbr -a gp   'git push'
abbr -a gpf  'git push --force-with-lease'
abbr -a gl   'git pull'
abbr -a glo  'git log --oneline --graph --decorate -20'
abbr -a glog 'git log --oneline --graph --decorate --all'
abbr -a gst  'git stash'
abbr -a gsp  'git stash pop'
abbr -a grh  'git reset --hard'
abbr -a gwip 'git commit -am wip'
abbr -a gunwip 'git reset --soft HEAD~1'
abbr -a gprune 'git fetch --prune'

# --- Navigation --------------------------------------------------------
abbr -a ..    'cd ..'
abbr -a ...   'cd ../..'
abbr -a ....  'cd ../../..'
abbr -a ..... 'cd ../../../..'

# --- Listings ----------------------------------------------------------
if type -q eza
    abbr -a l   'eza --icons'
    abbr -a ll  'eza --icons -l --git'
    abbr -a la  'eza --icons -la --git'
    abbr -a lt  'eza --icons --tree --level=2'
    abbr -a lta 'eza --icons --tree --level=2 -a'
else if type -q exa
    abbr -a l   'exa --icons'
    abbr -a ll  'exa --icons -l --git'
    abbr -a la  'exa --icons -la --git'
    abbr -a lt  'exa --icons --tree --level=2'
    abbr -a lta 'exa --icons --tree --level=2 -a'
else
    abbr -a l  'ls -CF'
    abbr -a ll 'ls -lah'
    abbr -a la 'ls -A'
end

# --- Editor ------------------------------------------------------------
if type -q nvim
    abbr -a n nvim
    abbr -a vim nvim
    abbr -a vi nvim
end

# --- Containers / Kubernetes ------------------------------------------
if type -q docker
    abbr -a d docker
    abbr -a dc 'docker compose'
    abbr -a dps 'docker ps'
    abbr -a di 'docker images'
    abbr -a dex 'docker exec -it'
    abbr -a dlog 'docker logs -f'
end

if type -q kubectl
    abbr -a k kubectl
    abbr -a kgp 'kubectl get pods'
    abbr -a kgs 'kubectl get svc'
    abbr -a kgd 'kubectl get deploy'
    abbr -a kctx 'kubectl config current-context'
    abbr -a kns 'kubectl config set-context --current --namespace'
end

# --- System/package managers -----------------------------------------
if type -q systemctl
    abbr -a sc systemctl
    abbr -a scu 'systemctl --user'
    abbr -a jctl 'journalctl -xeu'
end

if type -q brew
    abbr -a bi 'brew install'
    abbr -a bs 'brew search'
    abbr -a bu 'brew update; and brew upgrade'
end

if type -q pacman
    abbr -a pac 'sudo pacman'
    abbr -a pacs 'pacman -Ss'
    abbr -a paci 'sudo pacman -S'
    abbr -a pacr 'sudo pacman -Rns'
    abbr -a pacu 'sudo pacman -Syu --needed'
    abbr -a pacq 'pacman -Q'
    abbr -a pacqs 'pacman -Qs'
end

# --- Disk/process/network ---------------------------------------------
if type -q gdu
    abbr -a duh 'gdu -hd 1'
else
    switch (uname)
        case Darwin FreeBSD
            abbr -a duh 'du -hd 1'
        case '*'
            abbr -a duh 'du -h --max-depth=1'
    end
end
abbr -a dfh 'df -h'

if type -q rg
    abbr -a psg 'ps aux | rg'
else
    abbr -a psg 'ps aux | grep'
end

abbr -a myip 'curl -s https://ifconfig.me; echo'
abbr -a serve 'python3 -m http.server'

# --- Clipboard ---------------------------------------------------------
abbr -a copy fish_clipboard_copy
abbr -a paste fish_clipboard_paste

# --- Fish self-management ---------------------------------------------
abbr -a fcfg '$EDITOR ~/.config/fish/config.fish'
abbr -a frc 'source ~/.config/fish/config.fish'

# --- Styled interactive replacements ---------------------------------
if type -q bat
    abbr -a cat 'bat --theme=ansi --paging=never'
end
if type -q delta
    abbr -a diff delta
end

# --- Safer file operations --------------------------------------------
abbr -a cpv 'cp -iv'
abbr -a mvv 'mv -iv'
abbr -a rmi 'rm -I'
abbr -a rsy 'rsync -avhP'
