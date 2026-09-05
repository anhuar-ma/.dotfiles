# ~/.config/fish/conf.d/20-git-prompt.fish
#
# Configuration for `fish_git_prompt`, which is rendered inside the
# git-style prompt at functions/_prompt_git.fish.
#
# Knobs are documented at: https://fishshell.com/docs/current/cmds/fish_git_prompt.html

# --- Status segments ---------------------------------------------------
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_use_informative_chars   1
set -g __fish_git_prompt_showdirtystate          1
set -g __fish_git_prompt_showuntrackedfiles      1
set -g __fish_git_prompt_showupstream            informative
set -g __fish_git_prompt_showcolorhints          1
set -g __fish_git_prompt_color_branch            magenta

# --- Status glyphs -----------------------------------------------------
set -g __fish_git_prompt_char_stateseparator     " |"
set -g __fish_git_prompt_char_dirtystate         (printf " \uf040 ")
set -g __fish_git_prompt_char_untrackedfiles     " ?"
set -g __fish_git_prompt_char_cleanstate         (set_color green)\uf00c(set_color normal)

# --- Upstream arrows (quiet, readable) ---------------------------------
set -g __fish_git_prompt_char_upstream_ahead     " ↑"
set -g __fish_git_prompt_char_upstream_behind    " ↓"
set -g __fish_git_prompt_char_upstream_diverged  " ⇅"
set -g __fish_git_prompt_char_upstream_equal     ""    # hide "=" when up to date
set -g __fish_git_prompt_char_upstream_prefix    ""
