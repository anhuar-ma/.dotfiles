# ~/.config/fish/functions/reload.fish
#
# Re-source ~/.config/fish/config.fish without exiting the shell.
# Note: this re-runs config.fish in the current session. It does NOT
# reload conf.d/* (those are sourced once at fish startup); open a
# new fish window for those.

function reload --description 'Re-source ~/.config/fish/config.fish'
    source ~/.config/fish/config.fish
    echo "fish config reloaded"
end
