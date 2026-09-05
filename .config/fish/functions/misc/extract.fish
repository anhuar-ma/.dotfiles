# ~/.config/fish/functions/extract.fish
#
# Universal archive extractor. Picks the right tool based on the
# extension. Autoloaded by fish from the functions/ directory.
#
# Supports: .tar.{bz2,gz,xz,zst}, .tbz2, .tgz, .txz, .tar, .bz2, .gz,
# .xz, .zst, .zip, .7z, .rar.

function extract --description 'Extract any common archive'
    if test (count $argv) -ne 1
        echo "usage: extract <archive>" >&2
        return 2
    end

    set -l f $argv[1]
    if not test -f $f
        echo "extract: '$f' is not a file" >&2
        return 1
    end

    switch $f
        case '*.tar.bz2' '*.tbz2'
            tar xjf -- $f
        case '*.tar.gz' '*.tgz'
            tar xzf -- $f
        case '*.tar.xz' '*.txz'
            tar xJf -- $f
        case '*.tar.zst'
            tar --zstd -xf -- $f
        case '*.tar'
            tar xf -- $f
        case '*.bz2'
            bunzip2 -- $f
        case '*.gz'
            gunzip -- $f
        case '*.xz'
            unxz -- $f
        case '*.zst'
            unzstd -- $f
        case '*.zip'
            unzip -- $f
        case '*.7z'
            7z x -- $f
        case '*.rar'
            unrar x -- $f
        case '*'
            echo "extract: don't know how to handle '$f'" >&2
            return 2
    end
end
