# ~/.config/fish/config.fish
# Entry point kept intentionally small. Fish sources conf.d/*.fish first;
# this file adds function subdirectories, theme colors, and interactive policy.

# --- Function autoload subdirectories ---------------------------------
# Fish autoloads only ~/.config/fish/functions by default. Keep helper and
# prompt functions in subdirectories without duplicating fish_function_path on reload.
for dir in ~/.config/fish/functions/*/
    if test -d $dir; and not contains -- $dir $fish_function_path
        set -p fish_function_path $dir
    end
end

# --- History -----------------------------------------------------------
# Persist more history; commands prefixed with a space are still skipped.
set -g fish_history_max_size 100000

# --- Greeting & colors -------------------------------------------------
# Use a global variable instead of universal so this repo does not mutate
# machine-wide fish_variables when sourced during tests.
set -g fish_greeting ""

set -g fish_color_autosuggestion brblack --dim
set -g fish_color_command 5DF8D8
set -g fish_color_param white
set -g fish_color_redirection brmagenta
set -g fish_color_error red
set -g fish_color_comment brblack
set -g fish_color_quote yellow
set -g fish_color_operator brcyan
set -g fish_color_search_match --background=brblack

# --- Tmux auto-attach --------------------------------------------------
# Preserved from the original config. Set A_DISABLE_TMUX_AUTO_ATTACH=1 to
# start plain fish sessions without changing this file.
if status is-interactive
    and not set -q TMUX
    and not set -q A_DISABLE_TMUX_AUTO_ATTACH
    and type -q tmux
    and isatty stdin
    and isatty stdout
    and test "$TERM_PROGRAM" != vscode # Kiro/VS Code integrated terminal
    exec tmux new-session -A -s main
end

set PROMPT_USER ""
set PROMPT_HOST ""

set -g __fish_auto_ls_enabled 1
