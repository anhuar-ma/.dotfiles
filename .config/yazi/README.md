# Yazi config and field guide

This directory contains a practical Yazi setup tuned for a macOS developer workflow:

- `yazi.toml` — layout, preview behavior, openers, file rules, task concurrency.
- `keymap.toml` — extra keybindings layered on top of Yazi defaults.
- `theme.toml` — readable dark-terminal styling and filetype colors.

Yazi merges your config with its built-in defaults, so these files intentionally override only the pieces worth changing.

## Install

Recommended macOS install:

```sh
brew install yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font
brew link ffmpeg-full imagemagick-full -f --overwrite
```

Minimum hard requirement: `file`. The optional tools unlock the good stuff:

| Tool | What it enables |
|---|---|
| `ffmpeg` | Video thumbnails/previews |
| `sevenzip` / `7zz` | Archive previews and extraction |
| `jq` | Pretty JSON previews |
| `poppler` | PDF previews |
| `fd` | Filename search |
| `ripgrep` / `rg` | Content search |
| `fzf` | Fast subtree navigation |
| `zoxide` | Jump to frequently used dirs |
| `resvg` | SVG previews |
| ImageMagick `magick` | HEIC, JPEG XL, fonts, extra image formats |
| Nerd Font | File icons render correctly |

## Use this config

Copy or symlink the files into Yazi’s config directory:

```sh
mkdir -p ~/.config/yazi
cp yazi.toml keymap.toml theme.toml ~/.config/yazi/
```

Or test without replacing your current setup:

```sh
YAZI_CONFIG_HOME="$PWD" yazi
```

## Shell wrapper: leave Yazi and `cd` where you exited

Yazi cannot change the parent shell’s directory by itself. Use a wrapper named `y` and start Yazi with `y` instead of `yazi`.

Fish:

```fish
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    set cwd (cat "$tmp")
    if test -n "$cwd"; and test "$cwd" != "$PWD"; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
```

Bash/Zsh:

```sh
function y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  command rm -f -- "$tmp"
}
```

Quit with `q` to update the shell CWD. Quit with `Q` when you do **not** want to update CWD.

## Mental model

Yazi is a modal, keyboard-first terminal file manager:

- Left pane: parent directory.
- Middle pane: current directory.
- Right pane: preview of hovered file/directory.
- Selection is explicit: many operations act on selected files; if nothing is selected they act on the hovered file.
- Copy/cut is staged: `y` or `x`, move somewhere else, then `p`.
- Most popups have their own key layer. Press `F1` or `~` for context help anywhere.

## Core navigation

| Key | Action |
|---|---|
| `j` / `Down` | Move down |
| `k` / `Up` | Move up |
| `l` / `Right` / `Enter` | Enter directory/open file |
| `h` / `Left` | Leave to parent directory |
| `g g` | Top of list |
| `G` | Bottom of list |
| `J` / `K` | Scroll preview down/up |
| `z` | Jump/reveal with `fzf` |
| `Z` | Jump with `zoxide` |
| `g Space` | Interactive path prompt |
| `t t` | New tab in current directory |
| `1`…`9` | Switch tab |
| `[` / `]` | Previous/next tab |
| `{` / `}` | Move tab left/right |
| `Ctrl-c` | Close current tab |

Custom bookmarks in this config:

| Key | Destination |
|---|---|
| `g h` | Home |
| `g d` | `~/Downloads` |
| `g D` | `~/Desktop` |
| `g c` | `~/.config` |
| `g w` | `~/workplace` |
| `g a` | `~/.aki` |

If `~/workplace` does not exist, edit or remove that binding in `keymap.toml`.

## Selection and file operations

| Key | Action |
|---|---|
| `Space` | Toggle hovered file selection |
| `v` | Visual select mode |
| `V` | Visual unset mode |
| `Ctrl-a` | Select all |
| `Ctrl-r` | Invert selection |
| `Esc` | Clear selection/filter/search state |
| `y` | Yank/copy selected files |
| `x` | Yank/cut selected files |
| `p` | Paste |
| `P` | Paste and overwrite |
| `Y` / `X` | Cancel yank/cut state |
| `d` | Trash selected files |
| `D` | Permanently delete selected files |
| `a` | Create file; end with `/` to create directory |
| `r` | Rename hovered/selected files |
| `-` | Symlink absolute path of yanked files |
| `_` | Symlink relative path of yanked files |
| `Ctrl--` | Hardlink yanked files |

Bulk rename trick: select multiple files, press `r`, edit names in `$EDITOR`, save and exit. Yazi applies the rename batch.

## Opening files

| Key | Action |
|---|---|
| `o` / `Enter` | Open using rules |
| `O` / `Shift-Enter` | Choose opener interactively |
| `o r` | Open-with menu from this config |
| `Space q` | macOS Quick Look hovered file |
| `R` | Reveal hovered file in Finder |
| `Tab` | Spot/file info |

This config adds opener rules for:

- text/code: `$EDITOR`, then system open
- images/PDF: Quick Look, then system open
- audio/video: `mpv`, then system open
- archives: `unar`, then `7zz`, then system open

If you do not use `mpv` or `unar`, either install them or remove those opener entries.

## Search, find, and filter

| Key | Action |
|---|---|
| `f` | Filter current directory list |
| `/` | Find next matching filename in current list |
| `?` | Find previous matching filename |
| `n` / `N` | Next/previous find result |
| `s` | Search by filename using `fd` |
| `S` | Search contents using `ripgrep` |
| `Ctrl-s` | Cancel active search |

Good patterns:

- Use `f` when the file is probably in the visible directory.
- Use `/` when you want to jump among matches without hiding non-matches.
- Use `s` when the file is somewhere below the current directory.
- Use `S` when you remember text inside the file, not its name.

## Sorting and display

Defaults in this config:

- natural sort: `file2` before `file10`
- directories first
- hidden files off by default
- symlink targets visible
- `size` line mode

Useful keys:

| Key | Action |
|---|---|
| `.` | Toggle hidden files |
| `m s` | Show size line mode |
| `m m` | Show modified-time line mode |
| `m p` | Show permissions line mode |
| `m o` | Show owner line mode |
| `m n` | No line mode |
| `, n` | Sort naturally |
| `, m` | Sort by modified time, newest first |
| `, s` | Sort by size, largest first |
| `, e` | Sort by extension |

Yazi’s default sort menu also uses `,` combinations, so press `F1` if you want the complete list.

## Copy paths and run commands

| Key | Action |
|---|---|
| `c p` | Copy selected path(s), Unix separators |
| `c a` | Copy hovered path |
| `c f` | Copy filename |
| `c d` | Copy dirname |
| `;` | Run a shell command without blocking Yazi |
| `:` | Run a shell command and block until done |
| `!` | Open `$SHELL` in the current directory |
| `z p` | Zip selected files into `archive.zip` |
| `z x` | Extract selected archives with `unar` |

Shell command placeholders you will actually use:

| Placeholder | Meaning |
|---|---|
| `%h` | Hovered file path |
| `%s` | Selected file paths |
| `%d` | Selected parent directories |
| `%H`, `%S`, `%D` | URL-escaped versions |
| `%s1`, `%s2` | First, second selected file |
| `%%` | Literal percent sign |

Examples from `;` or `:`:

```sh
code %h
rg TODO %d
chmod +x %s
zip -r archive.zip %s
```

Use `:` for interactive/blocking commands. Use `;` for fire-and-forget commands.

## Preview tricks

Yazi previews a lot when optional dependencies are installed:

- source code with syntax highlighting
- Markdown/text with wrapping
- JSON via `jq`
- PDFs via Poppler
- images directly in supported terminals
- video thumbnails via `ffmpeg`
- archives via `7zz`

If previews look stale after changing image settings:

```sh
yazi --clear-cache
```

If image rendering is slow, lower these in `yazi.toml`:

```toml
[preview]
max_width = 1000
max_height = 1000
image_filter = "triangle"
image_quality = 70
```

## Tabs as workspaces

Tabs are cheap. A good workflow:

1. Open project root in tab 1.
2. `t t` a second tab for build artifacts/logs.
3. `t t` a third tab for downloads/temp files.
4. Use `1`, `2`, `3` to jump between them.
5. Use `[` / `]` when cycling is faster.

## Safer deletion habits

- Prefer `d` first. It moves to trash.
- Use `D` only when you really mean permanent deletion.
- Check the selected count in the status bar before deleting.
- Press `Esc` to clear selection before operating on only the hovered file.

## Best customizations to make next

1. Edit bookmark keys in `keymap.toml` so `g` routes match your real directories.
2. Add project-specific openers, for example `code %s` or `idea %s`.
3. Install a flavor from `yazi-rs/flavors` if you want a packaged theme.
4. Add plugins only after this base feels solid; the defaults plus these bindings already cover most workflows.

## Troubleshooting

| Symptom | Fix |
|---|---|
| Icons render as boxes | Use a Nerd Font in your terminal |
| `s` search fails | Install `fd` |
| `S` content search fails | Install `ripgrep` |
| JSON preview is raw/ugly | Install `jq` |
| PDF preview missing | Install `poppler` |
| Video preview missing | Install `ffmpeg` |
| Archive preview/extract missing | Install `sevenzip`; optionally `unar` |
| Quick Look key does nothing | macOS only; remove binding on Linux |
| `g w` errors | Create `~/workplace` or edit/delete that keybinding |

## References

- Yazi configuration overview: <https://yazi-rs.github.io/docs/configuration/overview/>
- `yazi.toml`: <https://yazi-rs.github.io/docs/configuration/yazi/>
- `keymap.toml`: <https://yazi-rs.github.io/docs/configuration/keymap/>
- `theme.toml`: <https://yazi-rs.github.io/docs/configuration/theme/>
- Installation dependencies: <https://yazi-rs.github.io/docs/installation/>
