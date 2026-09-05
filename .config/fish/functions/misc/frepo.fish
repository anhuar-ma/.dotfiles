function frepo --description 'Fuzzy cd into git repositories using fzf'
    command -q fzf; or begin
        echo 'frepo: fzf is required but not installed' >&2
        return 1
    end

    set -l search_dirs
    for d in ~/workplace ~/Codes ~/Code ~/src
        test -d $d; and set -a search_dirs $d
    end
    test (count $search_dirs) -gt 0; or begin
        echo 'frepo: no search directories found (~/workplace, ~/Codes, ~/Code, ~/src)' >&2
        return 1
    end

    set -l repo
    if command -q fd
        set repo (fd --hidden --type d '^\.git$' $search_dirs --exclude node_modules --exclude target --exclude .cache | string replace -r '/\.git$' '' | fzf --header='Select repository')
    else
        set repo (find $search_dirs -maxdepth 4 -name .git -type d 2>/dev/null | string replace -r '/\.git$' '' | fzf --header='Select repository')
    end
    test -n "$repo"; or return 0
    cd -- $repo
end
