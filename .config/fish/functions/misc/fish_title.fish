# TODO: Explain where this title appears
function fish_title
    if test "$IS_SSH" = 1
        echo (whoami)@(hostname -s): (prompt_pwd)
    else
        echo (prompt_pwd)
    end
end

