function fssh --description "Fuzzy SSH host selector using fzf"
    command -q fzf; or begin
        echo "fssh: fzf is required but not installed" >&2
        return 1
    end

    test -f ~/.ssh/config; or begin
        echo "fssh: ~/.ssh/config not found" >&2
        return 1
    end

    set -l host (awk '/^Host / && !/\*/ {print $2}' ~/.ssh/config | fzf --header="Select SSH host")
    test -n "$host"; or return 0

    ssh $host
end
