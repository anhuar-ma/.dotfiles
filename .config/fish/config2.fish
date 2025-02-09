if status is-interactive
    # Commands to run in interactive sessions can go here
    #neofetch
    #fish_vi_key_bindings
end

function fish_prompt --description 'Informative prompt'
    # Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status  # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) \
            (set -q fish_color_cwd_root; and set_color $fish_color_cwd_root or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        # Use a simpler prompt format
       #printf '[%s] %s@%s %s%s %s%s\n' (date "+%H:%M:%S") $USER (prompt_hostname) \
       #     (set_color $fish_color_cwd) (prompt_pwd) $pipestatus_string (set_color normal)

        echo (set_color ffb600)(prompt_pwd --full-length-dirs=3 --dir-length=3)
        echo (set_color red)'🔥 '(set_color E126E1)
        #set_color normal
    end
end

function gpp
    # Check if both arguments are provided
    if test (count $argv) -ne 2
        echo "Usage: gpp <std_version> <filename>"
        echo "Example: gpp 17 main.cpp"
        return 1
    end

    # Store arguments in variables
    set std_number $argv[1]
    set filename $argv[2]

    # Compile and run
    g++ -std=c++$std_number \
        -Wall \
        -Wextra \
        -Wconversion \
        -Wshadow \
        -Wfloat-equal \
        -fsanitize=address \
        -fsanitize=undefined \
        -fno-sanitize-recover \
        -D_GLIBCXX_DEBUG \
        -DDEBUG \
        $filename \
        && ./a.out
end

zoxide init fish --cmd cd | source
alias ls="exa --icons --colour=always"
alias la="exa --icons --colour=always -la"
alias vi="nvim"
alias pacman="sudo pacman"
alias upgrade-system="sudo pacman -Syu --needed"
alias copilot="gh copilo"
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"
alias diff="delta"
alias cat="bat --theme=ansi"
