if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
    fish_vi_key_bindings
end

zoxide init fish --cmd cd | source
alias ls="exa --icons --colour=always"
alias la="exa --icons --colour=always -la"
alias vi="nvim"
alias pacman="sudo pacman"
alias upgrade-system="sudo pacman -Syu --needed"
alias copilot="gh copilo"
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"
alias diff="delta"
alias cat="bat --theme=ansi"
