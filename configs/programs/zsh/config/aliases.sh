LS_COMMAND='lsd --almost-all --color always --group-directories-first --icon always'
alias btop="sudo btop"
alias graph="pacgraph --svg -b #000000 -l #013d35 -t #f40cfc -d #ffffff --show-req-by --by-area --explicits --opt-deps -f ~/Images/pacgraph/pacgraph"
alias musicback="rclone sync '$(realpath "$HOME/Music/Music")' drive-main:Music --progress --drive-use-trash=false --delete-excluded --copy-links"
alias z="__zoxide_z"
alias zf="__zoxide_zi"
alias ls="$LS_COMMAND"
alias fastfetch='fastfetch --logo-padding-left $(( ( $(tput cols) - 93) / 2 ))'
alias git-gc-all='git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc'
alias yt-music='yt-dlp -x --embed-thumbnail --embed-metadata --audio-quality --audio-quality --audio-format flac --postprocessor-args "ffmpeg:-compression_level 12"'
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

python-venv-install(){
    [[ -z "$1" ]] && {
        echo "please give a package name"
        exit 1
    }
    local root="$HOME/.local/share/ingenarel-pip"
    [[ ! -d "$root" ]] &&  mkdir --parents "$root"
    python3 -m venv "$root/$1"
    source "$root/$1/bin/activate"
    python3 -m pip install "$1"
}

python-venv-update(){
    local root="$HOME/.local/share/ingenarel-pip"
    find "$root" -maxdepth 1 -type d | tail -n+2 | while IFS='' read -r dirName; do
        source "$dirName/bin/activate"
        python3 -m pip install "$(basename "$dirName")" --upgrade
    done
}
