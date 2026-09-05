# Fish power-user configuration

This config is organized around Fish's conventional layout:

- `config.fish` — small entry point: function subdirectories, colors, history, tmux auto-attach.
- `conf.d/*.fish` — numbered startup modules; low numbers set PATH/tooling before shortcuts are defined.
- `functions/prompts/` — custom prompt dispatcher and prompt helpers.
- `functions/misc/` — autoloaded helper commands such as `mkcd`, `extract`, `ports`, `retry`, `frepo`.
- `tests/smoke.fish` — prompt-focused smoke tests.

## Design choices

- Abbreviations are preferred over aliases for interactive shortcuts, so scripts keep canonical command behavior and history records expanded commands.
- zoxide is initialized as `z`/`zi`, not as a `cd` replacement, to preserve Fish's normal `cd` semantics.
- mise is preferred over fnm/pyenv when installed. fnm/pyenv wrappers are lazy fallbacks only.
- Starship is opt-in with `set -gx A_USE_STARSHIP 1`; the custom prompt is default.
- ssh-agent reuses `~/.ssh/agent_env.fish` and starts a new agent without `eval` when needed.
- tmux auto-attach is preserved. Disable per session with `set -gx A_DISABLE_TMUX_AUTO_ATTACH 1`.
- Auto-ls after `cd` is available but off by default: `set -g __fish_auto_ls_enabled 1`.

## Prompt

The default prompt is compact outside git repositories and detailed inside git repositories. It shows:

- path shortening via `_prompt_pwd_smart`
- git branch/status through Fish's `fish_git_prompt`
- previous command exit status when non-zero
- right prompt with virtualenv/conda, container context, command duration, and clock

Use `prompt-mode git|default|toggle` to force or reset the two-line git-style prompt.

## Useful bindings

- `Ctrl+R` — fzf history search
- `Ctrl+O` — fzf file picker opened in `$EDITOR`
- `Ctrl+G` — fzf git branch switcher
- `Alt+C` — fzf directory picker
- `Alt+Z` — zoxide interactive jump
- `Ctrl+Z` — foreground a suspended/background job
- `Alt+.` — previous command's last argument
- `Alt+E` — edit the current command in `$EDITOR`

## Smoke test

Run:

```fish
fish tests/smoke.fish
```
