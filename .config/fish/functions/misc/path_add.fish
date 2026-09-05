function path_add -d 'Prepend directories to PATH if they exist and are not already present'
    for dir in $argv
        if test -d "$dir"
            fish_add_path --prepend --path $dir
        end
    end
end
