# ~/.config/fish/functions/_prompt_default.fish
# Minimal prompt used outside git repositories.

function _prompt_default --description 'Simple prompt for non-git directories'
    set -l last_status $argv[1]
    if test "$last_status" -ne 0
        set_color red
    else
        set_color blue
    end
    echo -n (_prompt_pwd_smart 3 3 18)
    echo -n ' '\uf005' '
    set_color normal
end
