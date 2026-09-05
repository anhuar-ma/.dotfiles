# ~/.config/fish/functions/take.fish
#
# Clone a git repo and cd into the resulting directory.
# Strips a trailing `.git` from the URL when picking the dir name.

function take --description 'git clone <url> and cd into the result'
    if test (count $argv) -ne 1
        echo "usage: take <repo-url>" >&2
        return 2
    end
    set -l url $argv[1]
    set -l dir (string replace -r '\.git$' '' -- (basename $url))
    git clone -- $url $dir; and cd -- $dir
end
