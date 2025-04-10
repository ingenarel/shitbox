alias btop="sudo btop"
alias discordo='discordo -token "$(gpg -d ~/.config/wofi/token.gpg)"'
alias graph="pacgraph --svg -b #000000 -l #013d35 -t #f40cfc -d #ffffff --show-req-by --by-area --explicits --opt-deps -f ~/Images/pacgraph/pacgraph"
alias musicback="rclone sync /mnt/G/system\ files\(G\)/music drive-alt:music --progress --drive-use-trash=false --delete-excluded"
alias z="__zoxide_z"
alias zf="__zoxide_zi"
alias nzf='nvim "$(fzf)"'
alias ls='lsd --almost-all --color always --group-directories-first'
alias lsl='lsd --almost-all --color always --group-directories-first -l'
alias fastfetch='fastfetch --logo-padding-left $(( ( $(tput cols) - 93) / 2 ))'
