function retry --description 'Retry a command until it succeeds or attempts are exhausted'
    argparse 'n/attempts=' 'd/delay=' -- $argv; or return 2
    set -l attempts 3
    set -q _flag_attempts; and set attempts $_flag_attempts
    set -l delay 1
    set -q _flag_delay; and set delay $_flag_delay

    if test (count $argv) -eq 0
        echo 'usage: retry [-n attempts] [-d delay_seconds] command [args...]' >&2
        return 2
    end

    for i in (seq $attempts)
        command $argv
        set -l s $status
        test $s -eq 0; and return 0
        test $i -eq $attempts; and return $s
        sleep $delay
    end
end
