# ~/.config/fish/conf.d/50-events.fish -- Small interactive event hooks.
status is-interactive; or return

set -g IS_SSH 0
if set -q SSH_CONNECTION; or set -q SSH_CLIENT; or set -q SSH_TTY
    set -g IS_SSH 1
end

set -g IS_PRIVATE 0
if set -q fish_private_mode
    set -g IS_PRIVATE 1
end

# Auto-ls is useful but noisy; enable with `set -g __fish_auto_ls_enabled 1`.
set -q __fish_auto_ls_enabled; or set -g __fish_auto_ls_enabled 0
function __auto_ls --on-variable PWD
    test "$__fish_auto_ls_enabled" = 1; or return
    if command -q eza
        eza --icons --group-directories-first
    else
        command ls
    end
end

# function __long_command_notify --on-event fish_postexec
#     test -n "$CMD_DURATION"; and test $CMD_DURATION -gt 10000; or return
#     set -l secs (math --scale=1 "$CMD_DURATION / 1000")
#     set -l cmd (string split ' ' -- $argv[1])[1]
#     printf '\a'
#     echo "took {$secs}s: $cmd"
# end
