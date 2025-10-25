LS_COMMAND='lsd --almost-all --color always --group-directories-first --icon always'
alias btop="sudo btop"
alias graph="pacgraph --svg -b #000000 -l #013d35 -t #f40cfc -d #ffffff --show-req-by --by-area --explicits --opt-deps -f ~/Images/pacgraph/pacgraph"
alias musicback="rclone sync /mnt/G/system\ files\(G\)/music drive-alt:music --progress --drive-use-trash=false --delete-excluded"
alias z="__zoxide_z"
alias zf="__zoxide_zi"
alias ls="$LS_COMMAND"
alias fastfetch='fastfetch --logo-padding-left $(( ( $(tput cols) - 93) / 2 ))'
alias git-gc-all='git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc'
# https://stackoverflow.com/questions/1904860/how-to-remove-unreferenced-blobs-from-my-git-repository
#
alias crdeps="$HOME/.config/shitbox/scripts/gentoo-dev-scripts/crdeps"

f(){
    localGitDir="$(git rev-parse --show-toplevel 2>/dev/null)" && cd "$localGitDir"
    local filename="$(fd --color=always --type file | fzf --ansi --preview='bat --color=always --decorations=never {}')"
    [[ -n "$filename" ]] && nvim "$filename"
}

d(){
    localGitDir="$(git rev-parse --show-toplevel 2>/dev/null)" && cd "$localGitDir"
    local dirname="$(fd --color=always --type directory | fzf --ansi --preview="$LS_COMMAND --tree {}")"
    [[ -n "$dirname" ]] && cd "$dirname"
}

c(){
    [[ -d "$1" ]] || mkdir --parents "$1"
    cd "$1"
}

discordo-setup(){
    wl-copy --paste-once "$(keepassxc-cli show --show-protected --attributes token $HOME/.config/shitbox/configs/secrets/passwords/Passwords.kdbx discord)"
    secret-tool store --label="Discord Token" service discordo username token
}

torsocks(){
    systemctl is-active tor > /dev/null 2>&1 || systemctl start tor > /dev/null 2>&1
    command torsocks "$@"
}
