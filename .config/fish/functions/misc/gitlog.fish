function gitlog -d "Pretty git log with graph"
    git log --graph --oneline --decorate --all --color=always $argv
end

