# ~/.config/fish/conf.d/31-aliases.fish
# Keep aliases rare: only canonical replacements, not typing shortcuts.
# Most interactive shortcuts live in abbreviations.fish so history shows real commands.

# GitHub Copilot extension names are canonical enough to keep as aliases.
if type -q gh
    alias copilot 'gh copilot'
    alias gcs 'gh copilot suggest'
    alias gce 'gh copilot explain'
end

# --- File listing (exa replaces ls) ------------------------------------
if type -q exa
    alias ls 'exa --icons --colour=always'
    alias la 'exa --icons --colour=always -la'
end

if type -q bat
    abbr -a cat  bat
    alias bat 'bat --theme=ansi --paging=never'
end
