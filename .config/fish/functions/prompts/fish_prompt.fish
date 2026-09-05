# ~/.config/fish/functions/fish_prompt.fish
# Dispatcher: detailed prompt in git repositories, compact prompt elsewhere.

function fish_prompt --description 'Informative prompt'
    set -l last_status $status

    set -l mode default
    if set -q __fish_prompt_mode
        set mode $__fish_prompt_mode
    end

    if test "$mode" = git
        _prompt_git $last_status
        return
    end

    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        _prompt_git $last_status
    else
        _prompt_default $last_status
    end
end
