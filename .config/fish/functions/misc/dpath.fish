# ~/.config/fish/functions/dpath.fish
#
# Print $PATH one entry per line. Useful for debugging missing binaries.
# (Fish stores PATH as a list internally; we just have to print each.)

function dpath --description 'Print $PATH, one entry per line'
    for p in $PATH
        echo $p
    end
end
