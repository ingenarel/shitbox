LS_COMMAND='lsd --almost-all --color always --group-directories-first --icon always'
alias btop="sudo btop"
alias graph="pacgraph --svg -b #000000 -l #013d35 -t #f40cfc -d #ffffff --show-req-by --by-area --explicits --opt-deps -f ~/Images/pacgraph/pacgraph"
alias musicback="rclone sync '$(realpath "$HOME/Music/Music")' drive-main:Music --progress --drive-use-trash=false --delete-excluded --copy-links"
alias z="__zoxide_z"
alias zf="__zoxide_zi"
alias ls="$LS_COMMAND"
alias fastfetch='fastfetch --logo-padding-left $(( ( $(tput cols) - 144) / 2 ))'
alias git-gc-all='git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc'
# https://stackoverflow.com/questions/1904860/how-to-remove-unreferenced-blobs-from-my-git-repository
alias yt-music='yt-dlp -x --embed-thumbnail --embed-metadata --audio-quality --audio-quality --audio-format flac --postprocessor-args "ffmpeg:-compression_level 12"'

alias aerc="torsocks aerc"

alias updateshit="$HOME/.config/shitbox/scripts/updateshit.sh"

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

trscks(){
    systemctl --quiet is-active tor || systemctl --quiet start tor
    torsocks "$@"
    systemctl --quiet is-enabled tor || {
        rg\
            --null-data\
            --quiet\
            --stop-on-nonmatch\
            --regexp='LD_PRELOAD=/usr/lib/torsocks/libtorsocks\.so'\
            /proc/*/environ 2>/dev/null\
            ||
        systemctl stop tor
    }
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

ircback(){
    local archiveDir
    archiveDir="$HOME/.local/share/weechat/logs-archive"
    [ ! -d "$archiveDir" ] && mkdir --parents "$archiveDir"
    local archiveFile
    archiveFile="$archiveDir/logs-$(cat /etc/machine-id).zpaq"
    zpaq add "$archiveFile" "$HOME/.local/share/weechat/logs" -m5
    rclone sync "$archiveFile" "drive-main:IRC-logs/$(basename "$archiveFile")" --progress --drive-use-trash=false --delete-excluded --copy-links
}

wshowkeys(){
    command wshowkeys\
        -a top\
        -a right\
        -m 0\
        -t 1\
        -F 20\
        -b '#3c0049'\
        -f '#f91dd1'\
        -s '#1de7f9'
}

fetch (){
    maxWidth="$(
        command fastfetch | while IFS='' read -r line; do
        echo "${#line}"
        done | sort --numeric-sort --reverse | head -n1
    )"
    command fastfetch --logo-padding-left $(( ( $(tput cols) - "$maxWidth") / 2 ))
}

imgpaste(){
    if [ -z "$1" ]; then
        # shit can't read from proc hence tmp file
        file="$(mktemp XXXXXXXXXX.png)"
        wl-paste > "$file"
        link="$(curl --silent -F "file=@$file" -Fexpires=24 https://0x0.st)"
    else
        link="$(curl --silent -F "file=@$1" -Fexpires=24 https://0x0.st)"
    fi
    [ -n "$link" ] && {
        echo "$link"
        notify-send 'paste completed at' "$link"
        wl-copy "$link"
    }
}

txtpaste(){
    if [ -z "$1" ]; then
        # shit can't read from proc hence tmp file
        file="$(mktemp XXXXXXXXXX)"
        wl-paste > "$file"
        link="$(gh gist create --public "$file")"
    else
        link="$(gh gist create --public "$1")"
    fi
    [ -n "$link" ] && {
        link="https://gist.githubusercontent.com/ingenarel/$( echo "$link" | grep -oE '[^/]+$' )/raw"
        echo "$link"
        notify-send 'paste completed at' "$link"
        wl-copy "$link"
    }
}
