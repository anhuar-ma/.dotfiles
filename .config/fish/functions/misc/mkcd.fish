# ~/.config/fish/functions/mkcd.fish
#
# `mkdir -p` and `cd` into the result in one step.
# Autoloaded by fish from the functions/ directory.

function mkcd --description 'mkdir -p and cd into it'
    if test (count $argv) -ne 1
        echo "usage: mkcd <dir>" >&2
        return 2
    end
    mkdir -p -- $argv[1]; and cd -- $argv[1]
end
