# ~/.config/fish/conf.d/03-mise.fish
#
# mise (polyglot runtime manager, ex-rtx) activation.
# Puts tools like node/npm/npx/python onto PATH per directory.

if type -q mise
    mise activate fish | source
end
