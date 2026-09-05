# ~/.config/fish/functions/fish_right_prompt.fish
# Right prompt: virtualenv, container context, command duration, and clock.

function fish_right_prompt --description 'Prompt right-side status segments'
    set -l segments
    set -l dim (set_color brblack)
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l normal (set_color normal)

    if set -q VIRTUAL_ENV
        # set -a segments $cyan'venv:'(basename $VIRTUAL_ENV)$normal
        set -a segments $cyan(basename $VIRTUAL_ENV)$normal
    else if set -q CONDA_DEFAULT_ENV
        # set -a segments $cyan'conda:'$CONDA_DEFAULT_ENV$normal
        set -a segments $cyan$CONDA_DEFAULT_ENV$normal
    end

    if test -f /.dockerenv
        set -a segments $yellow'container'$normal
    else if set -q container
        set -a segments $yellow$container$normal
    end

    # if test -n "$CMD_DURATION"; and test $CMD_DURATION -gt 100
    #     set -l duration
    #     if test $CMD_DURATION -gt 60000
    #         set duration (math --scale=1 "$CMD_DURATION / 60000")'m'
    #     else
    #         set duration (math --scale=1 "$CMD_DURATION / 1000")'s'
    #     end
    #     set -a segments $dim$duration$normal
    # end

    # set -a segments $dim(date '+%H:%M')$normal
    string join ' ' -- $segments
end
