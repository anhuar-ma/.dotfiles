# ~/.config/fish/conf.d/00-env.fish -- Environment variables and PATH.
# Keep this side-effect-light: no prompts, no long-running commands.

# XDG Base Directories.
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

# Editor preference. Detect once at startup; no alias shadows vi/vim.
if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx NVIM_LOG_FILE /dev/null
else if command -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR vi
    set -gx VISUAL vi
end

# Pager defaults. Keep PAGER executable-compatible; use bat interactively via abbrs.
set -gx PAGER less
set -gx LESS -R
if command -q nvim
    # Force groff to output legacy overstrikes instead of ANSI codes
    set -gx MANPAGER "nvim +Man!"
    # Ensure MANROFFOPT is cleared so Neovim gets the raw data it expects
    set -e MANROFFOPT
else
    set -gx MANPAGER less
end

# Stop virtualenv/virtualenvwrapper from injecting its own prefix; prompt renders it.
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

# Browser opener, platform-aware.
if command -q open
    set -gx BROWSER open
else if command -q xdg-open
    set -gx BROWSER xdg-open
end

# PATH. fish_add_path deduplicates and preserves list semantics.
fish_add_path -gP $HOME/.local/bin
fish_add_path -gP $HOME/bin
if test -d /home/linuxbrew/.linuxbrew/bin
    fish_add_path -gP /home/linuxbrew/.linuxbrew/bin
    fish_add_path -gP /home/linuxbrew/.linuxbrew/sbin
end
