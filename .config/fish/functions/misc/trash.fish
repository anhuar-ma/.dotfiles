function trash --description 'Move files to trash instead of deleting'
    if test (count $argv) -eq 0
        echo "Usage: trash <file...>" >&2
        return 1
    end
    set -l trash_dir ~/.local/share/Trash/files
    mkdir -p $trash_dir
    for f in $argv
        if not test -e $f
            echo "trash: '$f' does not exist" >&2
            continue
        end
        set -l base (basename $f)
        set -l dest $trash_dir/$base.(date +%Y%m%d_%H%M%S)
        mv $f $dest
    end
end

