# ~/.config/fish/functions/backup.fish
#
# Quick timestamped backup: copies <file> to <file>.bak.YYYYMMDD-HHMMSS
# and prints the new path.

function backup --description 'Copy file to file.bak.YYYYMMDD-HHMMSS'
    if test (count $argv) -ne 1
        echo "usage: backup <file>" >&2
        return 2
    end
    if not test -e $argv[1]
        echo "backup: '$argv[1]' does not exist" >&2
        return 1
    end
    set -l ts (date +%Y%m%d-%H%M%S)
    set -l dst $argv[1].bak.$ts
    cp -a -- $argv[1] $dst
    echo $dst
end
