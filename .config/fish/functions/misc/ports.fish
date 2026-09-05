function ports -d 'Show listening ports with process info'
    if command -q lsof
        command lsof -nP -iTCP -sTCP:LISTEN $argv
    else if command -q ss
        ss -tulnp $argv
    else
        echo 'Neither lsof nor ss found' >&2
        return 1
    end
end
