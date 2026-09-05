# tmux Power User Cheatsheet

> Tailored to your `~/.tmux.conf` (prefix = `Ctrl+b`). Skim once, drill the **★** rows.

**Legend**: `<P>` = prefix (`Ctrl+b`). `<P> X` = press prefix, release, then `X`. `Alt+X` and `Ctrl+X` are pressed without releasing.

---

## 1. Mental model (read this once)

tmux has three nested objects:

```
server
└── session   (workspace; survives terminal close)
    └── window   (tab)
        └── pane     (split inside a tab)
```

You **detach** from a session (`<P> d`); the server keeps it running. You **attach** later (`tmux a`). That is the whole point of tmux.

---

## 2. Shell-side commands (outside tmux)

| Command | What it does |
|---|---|
| `tmux` | start a new unnamed session |
| `tmux new -s work` ★ | new session named `work` |
| `tmux new -As main` ★ | attach to `main` if exists, else create it (idempotent) |
| `tmux ls` | list sessions |
| `tmux a` / `tmux a -t work` | attach to last / named session |
| `tmux kill-session -t work` | kill one session |
| `tmux kill-server` | kill everything |
| `tmux source ~/.tmux.conf` | reload config from outside |

**Pro tip — auto-attach in fish** (you already do this):
```fish
if status is-interactive
    and not set -q TMUX
    tmux new -As main
end
```

---

## 3. Sessions

| Keys | Action |
|---|---|
| `<P> n` ★ | **new session** (instant, auto-numbered name) |
| `<P> C` ★ | **new session** (prompts for name) |
| `<P> S` ★ | session tree (preview + jump) |
| `<P> Ctrl+j` ★ | fzf session switcher (popup) |
| `Alt+s` | toggle to last session |
| `<P> d` ★ | **detach** (back to shell, session keeps running) |
| `<P> D` | choose which client to detach |
| `<P> X` | confirm-kill current session |
| `<P> $` | rename current session |
| `<P> (` / `<P> )` | previous / next session |

---

## 4. Windows (tabs)

| Keys | Action |
|---|---|
| `<P> c` ★ | new window in current path |
| `<P> ,` ★ | rename current window |
| `<P> &` | kill current window (asks) |
| `<P> w` | window tree (all sessions, preview) |
| `<P> Tab` ★ | last window (toggle) |
| `<P> Ctrl+h` / `<P> Ctrl+l` | previous / next window (repeatable) |
| `Alt+1`…`Alt+9`, `Alt+0` ★ | jump to window 1..10 |
| `<P> N` | move window left (repeat) |
| `<P> M` | move window right (repeat) |
| `<P> .` | move window to a different index |
| `<P> f` | find window by name (default tmux) |

---

## 5. Panes (splits)

### Create / destroy

| Keys | Action |
|---|---|
| `<P> |` ★ | split **horizontal** (side-by-side), in current path |
| `<P> -` ★ | split **vertical** (stacked), in current path |
| `<P> \\` / `<P> _` | same as `|` / `-` (alt keys) |
| `<P> x` | kill current pane (asks) |
| `<P> !` | break pane out into its own window |
| `<P> @` | join a pane from elsewhere (followed by `<P> :join-pane`) |

### Navigate

| Keys | Action |
|---|---|
| `<P> h/j/k/l` ★ | left / down / up / right |
| `Alt+h/j/k/l` ★ | same, **vim-aware** — falls through to (n)vim if active |
| `<P> o` | cycle to next pane |
| `<P> ;` | toggle to last pane |
| `<P> q` | show pane numbers (then press number to jump) |

### Resize / arrange

| Keys | Action |
|---|---|
| `<P> H/J/K/L` ★ | resize 5 cols / 3 rows (repeatable) |
| `<P> =` | equalize layout |
| `<P> m` ★ | **zoom** current pane (toggle full-screen) |
| `<P> Space` | cycle preset layouts (even-h, even-v, main-h, main-v, tiled) |
| `<P> >` / `<P> <` | swap pane down / up |
| `<P> {` / `<P> }` | move pane in stack left / right |
| `<P> z` (default) | also zoom (same as `m`) |

> Zoom (`m`/`z`) is the single biggest workflow tool. Need full screen for one pane? Zoom. Done? Zoom again.

---

## 6. Copy mode (vi keys)

Enter with `<P> v` (or `<P> [`). You're now navigating the scrollback like vim.

| Keys (in copy-mode) | Action |
|---|---|
| `h/j/k/l`, `w/b/e`, `0/$`, `gg/G` | vim motions |
| `H` / `L` | start / end of visible line |
| `/` / `?` ★ | search forward / backward |
| `n` / `N` | repeat search |
| `v` ★ | start selection |
| `Ctrl+v` | toggle rectangle (block) selection |
| `y` ★ | **yank** (copy to system clipboard via OSC 52) |
| `Y` | yank to end of line |
| `Escape` / `q` | exit copy mode |
| Mouse drag | selects without exiting copy mode |

### Paste

| Keys | Action |
|---|---|
| `<P> ]` | paste last buffer |
| `<P> P` | choose buffer (preview list) |

### Outside tmux: clipboard
Yanking with `y` writes to **your terminal's system clipboard** via OSC 52 — works through SSH, no extra tooling needed (assuming your local terminal supports it, which Alacritty / iTerm2 / WezTerm / kitty all do).

---

## 7. Popups (floating windows)

| Keys | Action |
|---|---|
| `<P> g` ★ | floating shell in current pane's path |
| `<P> G` | floating **lazygit** |
| `<P> Ctrl+j` | fzf session switcher |
| `<P> ?` | searchable list of all keybindings |
| `<P> :` | command prompt (run any tmux command) |

> Popups are great for quick `git log`, a calculator, `htop`, etc. without disturbing your layout.

---

## 8. Plugins (TPM)

Plugins live in `~/.tmux/plugins/`.

| Keys | Action |
|---|---|
| `<P> I` | install plugins listed in config |
| `<P> U` | update plugins |
| `<P> Alt+u` | uninstall plugins removed from config |

Active plugins:

| Plugin | What it gives you |
|---|---|
| **tmux-sensible** | sane defaults baseline |
| **tmux-yank** | better OSC 52 copy + `Y` to copy line |
| **tmux-resurrect** | save/restore sessions to disk |
| **tmux-continuum** | auto-save sessions every 15 min |
| **tmux-fzf** | `<P> F` → fuzzy interface for sessions/windows/panes/keys |
| **tmux-thumbs** | `<P> Space` → vimium-style hint mode to grab URLs/hashes/paths from screen |
| **tmux-fzf-url** | `<P> u` → fuzzy-pick a URL from the current pane and open it |

### Resurrect (manual)
| Keys | Action |
|---|---|
| `<P> W` | save current state |
| `<P> R` | restore last saved state |

`tmux-continuum` saves automatically; `restore = on` means you get your sessions back after a reboot.

---

## 9. Status bar

| Symbol | Meaning |
|---|---|
| `●` (blue) | normal mode |
| `⌨` (yellow) | prefix is active (just pressed `Ctrl+b`) |
| `⚡` ` ` after window name | pane is zoomed |
| `~` after window name | last (alternate) window |

Right side shows: cwd · git branch · hostname · time. Updates every 5 s.

---

## 10. Reload / config

| Keys | Action |
|---|---|
| `<P> r` ★ | reload `~/.tmux.conf` |
| `<P> :` | open command prompt, type any tmux command |

Useful prompt commands:

```
:source ~/.tmux.conf       # reload
:show-options -g           # show global options
:list-keys                 # list every keybinding
:swap-window -t :0         # move window to position 0
:move-window -r            # renumber all windows
:setw synchronize-panes    # type into ALL panes at once (toggle)
```

> `synchronize-panes` is a power move: split into 4 ssh sessions, toggle sync, type once, hit Enter on all four.

---

## 11. Workflows that pay off

### A. Project session per repo
```bash
cd ~/Codes/cpp && tmux new -As cpp
```
Each repo gets its own session. `<P> S` to swap between them.

### B. Three-pane dev layout
```
<P> -            # split bottom
<P> |            # split right of top
# top-left: editor (nvim)
# top-right: shell
# bottom: long-running (test runner / server)
<P> m            # zoom whichever you're focused on
```

### C. Send same command to multiple panes
```
<P> :setw synchronize-panes on
# type once, runs everywhere
<P> :setw synchronize-panes off
```

### D. Swap pane between windows
```
<P> !       # current pane → its own window
<P> @       # bring a pane in from another window
```

### E. Resurrect after reboot
With `tmux-continuum`, just start tmux. If it didn't auto-restore: `<P> R`.

### F. Capture pane output to file
```
<P> :capture-pane -S -3000   # capture last 3000 lines into buffer
<P> :save-buffer ~/out.txt
```

---

## 12. The 15 keys to drill first

If you only learn these, you're already ahead of 90% of users:

1. `<P> d` — detach
2. `<P> c` — new window
3. `<P> ,` — rename window
4. `<P> |` `<P> -` — splits
5. `<P> h/j/k/l` (or `Alt+h/j/k/l`) — pane nav
6. `<P> H/J/K/L` — resize
7. `<P> m` — zoom toggle
8. `<P> Tab` — last window
9. `Alt+1..9` — jump to window N
10. `<P> S` — session picker
11. `<P> n` / `<P> C` — new session (quick / named)
12. `<P> v` then `v`/`y` — copy mode
13. `<P> ]` — paste
14. `<P> r` — reload config
15. `<P> ?` — show all keys (your own help)

---

## 13. Mistakes everyone makes once

- **Closing your terminal kills your session.** It doesn't — that's the whole point. Use `<P> d`, then `tmux a` later.
- **Nesting tmux inside tmux on SSH.** Use a different prefix on the remote, or just don't nest — use sessions instead.
- **Forgetting prefix.** When in doubt, the status bar's `●`/`⌨` indicator tells you whether prefix is armed.
- **Trying to scroll with the mouse but it goes into history.** That's copy mode — press `q` to exit.
- **`Ctrl+S` freezes the terminal.** It's XOFF flow control. Run `stty -ixon` once in your shell rc.

---

## 14. Cheat for the cheat

Everything above is in your config already. To rediscover anything:

```
<P> ?           # interactive list of every binding
:list-keys -T copy-mode-vi    # copy-mode bindings
man tmux        # the bible -- search /KEY BINDINGS
```

---

*Config: `/home/archi/.tmux.conf` · prefix: `Ctrl+b` · target: tmux 3.2+*
