function fkill --description "Fuzzy process killer using fzf"
    command -q fzf; or begin
        echo "fkill: fzf is required but not installed" >&2
        return 1
    end

    set -l pid (ps aux | sed 1d | fzf --multi --header="Select process(es) to kill" | awk '{print $2}')
    test -n "$pid"; or return 0

    for p in $pid
        kill $p; and echo "Killed PID $p"
        or echo "Failed to kill PID $p (try: sudo kill $p)" >&2
    end
end
