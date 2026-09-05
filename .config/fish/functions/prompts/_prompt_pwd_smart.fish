# ~/.config/fish/functions/_prompt_pwd_smart.fish
#
# Smart path shortener:
#
#   - $HOME is collapsed to ~
#   - Segments before the last `keep` are hard-truncated to `dir_len`
#     characters (no ellipsis; matches `prompt_pwd --dir-length=N`).
#   - Middle tail segments (last `keep` segments, excluding the final
#     one when `full_last` is true) are shortened in the middle when
#     they exceed `max_full` chars, keeping `left_chars` on the left
#     and `right_chars` on the right around a single ellipsis.
#   - If `max_paths` > 0 and the total number of segments exceeds it,
#     the leading overflow is collapsed to a single `…` segment.
#   - The current directory (final segment) is left untouched when
#     `full_last` is true, otherwise it gets the same middle-shortening
#     treatment as other tail segments.
#
# Positional args (all optional):
#   1  keep         number of tail segments kept (default 3)
#   2  dir_len      hard truncate width for early segments (default 3)
#   3  max_full     trigger length for middle-shortening (default 12)
#   4  max_paths    cap on total displayed segments, 0 = unlimited (default 0)
#   5  full_last    'true'/'false' — leave final segment untouched (default true)
#   6  left_chars   chars kept on the left of the ellipsis (default 4)
#   7  right_chars  chars kept on the right of the ellipsis (default 4)

function _prompt_pwd_smart --description 'Smart prompt_pwd with configurable shortening'
    # --- Defaults -------------------------------------------------------
    set -l keep        3
    set -l dir_len     3
    set -l max_full    12
    set -l max_paths   0
    set -l full_last   true
    set -l left_chars  4
    set -l right_chars 4

    if set -q argv[1]; set keep        $argv[1]; end
    if set -q argv[2]; set dir_len     $argv[2]; end
    if set -q argv[3]; set max_full    $argv[3]; end
    if set -q argv[4]; set max_paths   $argv[4]; end
    if set -q argv[5]; set full_last   $argv[5]; end
    if set -q argv[6]; set left_chars  $argv[6]; end
    if set -q argv[7]; set right_chars $argv[7]; end

    # --- Collapse $HOME → ~ --------------------------------------------
    # Escape regex metacharacters in $HOME so paths like /home/archii
    # cannot match unrelated directories via regex bleed.
    set -l home_re (string escape --style=regex -- $HOME)
    set -l path (string replace -r '^'"$home_re"'($|/)' '~$1' -- $PWD)

    # Pull off a leading '/' or '~' so it isn't split or truncated.
    set -l prefix ''
    if string match -q '/*' -- $path
        set prefix '/'
        set path (string sub -s 2 -- $path)
    else if string match -q '~*' -- $path
        set path (string sub -s 2 -- $path)
        set path (string trim -l -c '/' -- $path)
        if test -z "$path"
            set prefix '~'
        else
            set prefix '~/'
        end
    end

    set -l parts (string split '/' -- $path)
    if test (count $parts) -gt 0; and test -z "$parts[1]"
        set parts $parts[2..-1]
    end

    # --- Cap total segments --------------------------------------------
    set -l truncated_head false
    if test $max_paths -gt 0; and test (count $parts) -gt $max_paths
        set parts $parts[(math (count $parts) - $max_paths + 1)..-1]
        set truncated_head true
    end

    set -l total  (count $parts)
    set -l cutoff (math "$total - $keep")  # indices ≤ cutoff → hard truncate

    set -l out
    if test $total -eq 0
        echo -n $prefix
        return 0
    end

    for i in (seq $total)
        set -l seg $parts[$i]
        set -l is_last false
        if test $i -eq $total
            set is_last true
        end

        if test $i -le $cutoff
            # Early segment: hard truncate, no ellipsis.
            set seg (string sub -l $dir_len -- $seg)
        else if test $is_last = false; or test $full_last != true
            # Tail segment (or last when full_last=false):
            # shorten in the middle if too long.
            set -l len (string length -- $seg)
            if test $len -gt $max_full
                set -l budget (math "$left_chars + $right_chars")
                if test $budget -le 0
                    # Nothing to keep; just hard-truncate.
                    set seg (string sub -l $max_full -- $seg)
                else if test $left_chars -ge $len; or test $right_chars -ge $len
                    # Sides bigger than the string; leave untouched.
                else
                    set -l head (string sub -l $left_chars -- $seg)
                    set -l tail (string sub -s (math "$len - $right_chars + 1") -- $seg)
                    set seg $head'…'$tail
                end
            end
        end
        # Final segment when full_last=true: untouched.
        set out $out $seg
    end

    # Force $joined to be a single-element list (possibly empty) so the
    # final $prefix$joined concatenation cannot collapse to a zero-element
    # list when $out is empty (e.g. when $PWD == $HOME).
    set -l joined ''
    if test (count $out) -gt 0
        set joined (string join '/' -- $out)
    end
    if test $truncated_head = true
        set joined '…/'$joined
    end

    # Separator between '~' and the rest of the path, but not when
    # we're sitting in $HOME itself (joined is empty).
    if test "$prefix" = '~'; and test -n "$joined"
        echo -n $prefix'/'$joined
    else
        echo -n $prefix$joined
    end
end
