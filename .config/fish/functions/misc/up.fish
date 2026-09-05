# ~/.config/fish/functions/up.fish
#
# Walk up N parent directories. `up` (no arg) goes up one level,
# `up 3` goes up three. Autoloaded by fish.

function up --description 'cd up N levels (default 1)'
    set -l n 1
    if test (count $argv) -ge 1
        set n $argv[1]
    end
    if not string match -qr '^[0-9]+$' -- $n; or test $n -lt 1
        echo "usage: up [positive integer]" >&2
        return 2
    end
    set -l target ''
    for i in (seq $n)
        set target ../$target
    end
    cd $target
end
