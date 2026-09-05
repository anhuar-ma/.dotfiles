# ~/.config/fish/conf.d/10-integrations.fish -- Interactive tool integrations.
status is-interactive; or return

# fzf shell integration. The generated script supplies native keybindings and completions.
if command -q fzf
    set -q FZF_DEFAULT_OPTS; or set -gx FZF_DEFAULT_OPTS "--bind 'tab:down,btab:up'"
    set -q FZF_COMPLETION_OPTS; or set -gx FZF_COMPLETION_OPTS "--bind 'tab:down,btab:up'"
    fzf --fish | source
end

# zoxide directory jumping. Keep the original `cd` command intact; use z/zi.
if command -q zoxide
    zoxide init fish --cmd cd | source
end

# direnv must hook immediately to load an .envrc in the starting directory.
if command -q direnv
    direnv hook fish | source
end

# mise is the preferred runtime manager in this setup. If it is installed,
# skip fnm/pyenv wrappers here to avoid competing PATH mutations.
if command -q mise
    # Activation lives in conf.d/mise.fish so it remains easy to disable.
else
    if command -q fnm
        function node --wraps=node --description 'Lazy fnm initialization for node'
            functions -e node npm npx
            fnm env --use-on-cd --shell fish | source
            command node $argv
        end
        function npm --wraps=npm --description 'Lazy fnm initialization for npm'
            functions -e node npm npx
            fnm env --use-on-cd --shell fish | source
            command npm $argv
        end
        function npx --wraps=npx --description 'Lazy fnm initialization for npx'
            functions -e node npm npx
            fnm env --use-on-cd --shell fish | source
            command npx $argv
        end
    end

    if command -q pyenv
        set -gx PYENV_ROOT $HOME/.pyenv
        fish_add_path $PYENV_ROOT/bin
        function python --wraps=python --description 'Lazy pyenv initialization for python'
            functions -e python python3 pip pip3
            pyenv init - fish | source
            command python $argv
        end
        function python3 --wraps=python3 --description 'Lazy pyenv initialization for python3'
            functions -e python python3 pip pip3
            pyenv init - fish | source
            command python3 $argv
        end
        function pip --wraps=pip --description 'Lazy pyenv initialization for pip'
            functions -e python python3 pip pip3
            pyenv init - fish | source
            command pip $argv
        end
        function pip3 --wraps=pip3 --description 'Lazy pyenv initialization for pip3'
            functions -e python python3 pip pip3
            pyenv init - fish | source
            command pip3 $argv
        end
    end
end

# Keep the custom prompt by default. Opt into Starship explicitly when wanted.
if set -q A_USE_STARSHIP; and command -q starship
    starship init fish | source
end

# Styled git diffs where git expects a pager.
if command -q delta
    set -gx GIT_PAGER delta
end


# fuzzy autocomplet for tab
if status is-interactive
    # in case it doesn't work , check what is shift+tab bind to 
    # bind | grep -i "tab"
    bind \t complete-and-search
end
