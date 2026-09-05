# ~/.config/fish/conf.d/40-keybindings.fish
# Extra bindings are composed with any existing fish_user_key_bindings function,
# so plugin-provided bindings are not accidentally replaced.
status is-interactive; or return

function __fzf_history --description 'Search command history with fzf'
    command -q fzf; or return 1
    set -l cmd (history | fzf --height=40% --reverse --query=(commandline))
    if test -n "$cmd"
        commandline -r -- $cmd
    end
    commandline -f repaint
end

function __fzf_open_file --description 'Find a file and open it in $EDITOR'
    command -q fzf; or return 1
    set -l candidates
    if command -q fd
        set candidates (fd --type f --hidden --exclude .git)
    else
        set candidates (find . -type f -not -path '*/.git/*' 2>/dev/null)
    end
    set -l file (printf '%s\n' $candidates | fzf --height=40% --reverse --preview='test -f {} && sed -n "1,80p" {}')
    if test -n "$file"
        commandline -r -- "$EDITOR "(string escape -- $file)
        commandline -f execute
    end
    commandline -f repaint
end

function __fzf_git_branch --description 'Switch git branches using fzf'
    command -q git; and command -q fzf; or return 1
    git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return 0

    set -l branch (git branch --all --format='%(refname:short)' | string replace -r '^origin/' '' | sort -u | fzf --height=40% --reverse)
    if test -n "$branch"
        commandline -r -- 'git switch '(string escape -- $branch)
        commandline -f execute
    end
    commandline -f repaint
end

function __fzf_cd --description 'Change directory with fd/find + fzf'
    command -q fzf; or return 1
    set -l dir
    if command -q fd
        set dir (fd --type d --hidden --exclude .git | fzf --height=40% --reverse)
    else
        set dir (find . -type d -not -path '*/.git/*' 2>/dev/null | fzf --height=40% --reverse)
    end
    if test -n "$dir"
        cd -- $dir
    end
    commandline -f repaint
end

function __fzf_zoxide --description 'Jump with zoxide interactive query'
    command -q zoxide; and command -q fzf; or return 1
    set -l dir (zoxide query -i)
    if test -n "$dir"
        cd -- $dir
    end
    commandline -f repaint
end

function __fg_current_job --description 'Bring most recent job to foreground'
    if jobs -q
        fg
    else
        commandline -f repaint
    end
end

# Chain any binding function that was already defined by another module/plugin.
if functions -q fish_user_key_bindings
    functions -c fish_user_key_bindings __fish_user_key_bindings_previous
end

function fish_user_key_bindings
    if functions -q __fish_user_key_bindings_previous
        __fish_user_key_bindings_previous
    end

    bind \cf forward-char
    bind \e. history-token-search-backward
    bind \e\[1\;5C forward-bigword
    bind \e\[1\;5D backward-bigword
    bind \cH backward-kill-word
    bind \e\[3\;5~ kill-word
    bind \ee edit_command_buffer
    bind \cz __fg_current_job

    if command -q fzf
        bind \cr __fzf_history
        bind \co __fzf_open_file
        bind \ec __fzf_cd
    end
    if command -q fzf; and command -q git
        bind \cg __fzf_git_branch
    end
    if command -q fzf; and command -q zoxide
        bind \ez __fzf_zoxide
    end
end
