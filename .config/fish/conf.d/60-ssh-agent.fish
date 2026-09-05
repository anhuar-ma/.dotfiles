# ~/.config/fish/conf.d/60-ssh-agent.fish -- Reuse or start ssh-agent safely.
# Preserves ~/.ssh/agent_env.fish but avoids eval; the cache file contains fish syntax.
status is-interactive; or return
command -q ssh-agent; or return

function __ssh_agent_usable --description 'Return 0 when SSH_AUTH_SOCK points at a live agent'
    set -q SSH_AUTH_SOCK; or return 1
    test -S "$SSH_AUTH_SOCK"; or return 1
    ssh-add -l >/dev/null 2>&1
    set -l add_status $status
    test $add_status -eq 0 -o $add_status -eq 1
end

set -l agent_file $HOME/.ssh/agent_env.fish
if not __ssh_agent_usable; and test -f $agent_file
    source $agent_file >/dev/null 2>&1
end

if not __ssh_agent_usable
    set -l agent_out (ssh-agent -s)
    set -l sock (string match --regex --groups-only '^SSH_AUTH_SOCK=([^;]+);' -- $agent_out)
    set -l pid  (string match --regex --groups-only '^SSH_AGENT_PID=([^;]+);' -- $agent_out)

    if test -n "$sock"; and test -n "$pid"
        set -gx SSH_AUTH_SOCK $sock
        set -gx SSH_AGENT_PID $pid
        mkdir -p $HOME/.ssh
        printf 'set -gx SSH_AUTH_SOCK %s\nset -gx SSH_AGENT_PID %s\n' \
            (string escape -- $SSH_AUTH_SOCK) \
            (string escape -- $SSH_AGENT_PID) >$agent_file
        chmod 600 $agent_file
    end
end

functions -e __ssh_agent_usable
