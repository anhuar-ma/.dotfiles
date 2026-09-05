function vscode-refresh --description 'Repoint VSCODE_IPC_HOOK_CLI at the live editor socket'
    set -l tmpdir (string replace -r '/$' '' -- (set -q TMPDIR; and echo $TMPDIR; or echo /tmp))
    set -l sock

    if command -q lsof
        set sock (lsof -U 2>/dev/null | string match -r "$tmpdir/vscode-ipc-[^[:space:]]*\.sock" | head -n1)
    end
    if test -z "$sock"
        set sock (command ls -t $tmpdir/vscode-ipc-*.sock 2>/dev/null | head -n1)
    end

    if test -n "$sock"
        set -gx VSCODE_IPC_HOOK_CLI $sock
        echo "VSCODE_IPC_HOOK_CLI → $sock"
    else
        echo "no vscode-ipc socket found in $tmpdir" >&2
        return 1
    end
end

function __vscode_refresh_on_git_dv --on-event fish_preexec
    if set -q argv[1]; and string match -q 'git dv*' -- $argv[1]
        vscode-refresh >/dev/null 2>&1
    end
end
