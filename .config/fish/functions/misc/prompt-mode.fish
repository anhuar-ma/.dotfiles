# ~/.config/fish/functions/prompt-mode.fish
#
# Switch the prompt between the default dispatcher (git-style inside repos,
# minimal outside) and a forced git-style prompt that renders everywhere.

function prompt-mode --description 'Switch fish prompt between default and git-forced modes'
    set -l current default
    if set -q __fish_prompt_mode
        set current $__fish_prompt_mode
    end

    if test (count $argv) -eq 0
        echo "prompt-mode: current = $current"
        echo "usage: prompt-mode git|default|toggle"
        return 0
    end

    switch $argv[1]
        case git default
            set -U __fish_prompt_mode $argv[1]
            echo "prompt-mode: $argv[1]"
        case toggle
            if test "$current" = git
                set -U __fish_prompt_mode default
                echo "prompt-mode: default"
            else
                set -U __fish_prompt_mode git
                echo "prompt-mode: git"
            end
        case '*'
            echo "prompt-mode: unknown argument '$argv[1]'" >&2
            echo "usage: prompt-mode git|default|toggle" >&2
            return 2
    end
end

