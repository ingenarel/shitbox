LS_COMMAND='lsd --almost-all --color always --group-directories-first'
alias btop="sudo btop"
alias discordo='discordo -token "$(gpg -d ~/.config/wofi/token.gpg)"'
alias graph="pacgraph --svg -b #000000 -l #013d35 -t #f40cfc -d #ffffff --show-req-by --by-area --explicits --opt-deps -f ~/Images/pacgraph/pacgraph"
alias musicback="rclone sync /mnt/G/system\ files\(G\)/music drive-alt:music --progress --drive-use-trash=false --delete-excluded"
alias z="__zoxide_z"
alias zf="__zoxide_zi"
alias ls="$LS_COMMAND"
alias fastfetch='fastfetch --logo-padding-left $(( ( $(tput cols) - 93) / 2 ))'
alias git-gc-all='git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc'
# https://stackoverflow.com/questions/1904860/how-to-remove-unreferenced-blobs-from-my-git-repository
#
alias create-deps="$HOME/.config/shitbox/scripts/gentoo/deps.sh"

f(){
    local filename="$(fd --color=always --type file | fzf --ansi --preview='bat --color=always --decorations=never {}')"
    [[ -n "$filename" ]] && nvim "$filename"
}

d(){
    local dirname="$(fd --color=always --type directory | fzf --ansi --preview="$LS_COMMAND {}")"
    [[ -n "$dirname" ]] && cd "$dirname"
}
