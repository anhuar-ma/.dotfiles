function path_remove -d 'Remove directories from PATH'
    for dir in $argv
        set -l idxs (contains -i -- "$dir" $PATH)
        for idx in $idxs[-1..1]
            set -e PATH[$idx]
        end
    end
end
