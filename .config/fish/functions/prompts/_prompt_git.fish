# ~/.config/fish/functions/_prompt_git.fish
# Detailed two-line prompt used inside git repositories.
# Keeps fish_git_prompt's default git-directory emojis/glyphs via git-prompt.fish.

function _prompt_git --description 'Detailed prompt for git repositories'
    set -l last_status $argv[1]

    set -l c_frame (set_color brblack)
    set -l c_user (set_color yellow)
    set -l c_host (set_color cyan)
    set -l c_path (set_color blue)
    set -l c_text (set_color normal)
    set -l c_err (set_color red)

    set -l ssh_tag ''
    if set -q SSH_CONNECTION; or set -q SSH_CLIENT; or set -q SSH_TTY
        set c_host (set_color magenta)
        set ssh_tag (set_color brblack)'ssh '$c_text
    end

    set -l user_label
    if set -q PROMPT_USER
        set user_label $PROMPT_USER
    else
        set user_label $USER
    end
    set -l host_label
    if set -q PROMPT_HOST
        set host_label $PROMPT_HOST
    else
        set host_label (prompt_hostname)
    end

    echo -n $c_frame'╭─ '$c_text
    echo -n $ssh_tag

    if test -n "$user_label"; and test -n "$host_label"
        echo -n $c_user$user_label$c_text
        echo -n $c_frame'@'$c_text
        echo -n $c_host$host_label$c_text
        echo -n $c_frame' in '$c_text
    else if test -n "$user_label"
        echo -n $c_user$user_label$c_text
        echo -n $c_frame' in '$c_text
    else if test -n "$host_label"
        echo -n $c_host$host_label$c_text
        echo -n $c_frame' in '$c_text
    end

    echo -n $c_path(_prompt_pwd_smart 3 3 18)$c_text

    set -l git_info (fish_git_prompt)
    if test -n "$git_info"
        echo -n $c_frame' on'$c_text$git_info
    end

    if test $last_status -ne 0
        echo -n ' '$c_err'✘ '$last_status$c_text
    end

    echo

    echo -n $c_frame'╰─'$c_text
    if test $last_status -ne 0
        set_color red
    else
        set_color green
    end
    echo -n '❯ '
    set_color normal
end
