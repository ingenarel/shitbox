SSH_ENV="/tmp/ssh-agent.env"

[ -d "$HOME/.ssh" ] || mkdir --parents "$HOME/.ssh"

! pgrep 'ssh-agent' > /dev/null && {
    eval "$(ssh-agent -s)" > /dev/null
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$SSH_ENV"
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$SSH_ENV"
    chmod 600 "$SSH_ENV"
} || source "$SSH_ENV"
