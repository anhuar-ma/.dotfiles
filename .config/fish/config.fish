if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
    fish_vi_key_bindings
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/anhuar/anaconda3/bin/conda
    eval /home/anhuar/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

