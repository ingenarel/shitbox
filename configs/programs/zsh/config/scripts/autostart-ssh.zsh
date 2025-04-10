SSH_ENV="$HOME/.ssh/ssh-agent.env"

start_ssh_agent() {
    eval "$(ssh-agent -s)" > /dev/null
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$SSH_ENV"
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$SSH_ENV"
    chmod 600 "$SSH_ENV"
}

if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    if ! kill -0 "$SSH_AGENT_PID" > /dev/null 2>&1; then
        start_ssh_agent
    fi
else
    start_ssh_agent
fi

if [[ -f $HOME/.ssh/git.pub ]]; then;
    ;
else;
    ssh-keygen -t ed25519 -C "ingenarelitems@gmail.com" -f $HOME/.ssh/git;
    ssh-add $HOME/.ssh/git;
    echo "
    Host github.com
        User git
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile $HOME/.ssh/git
        AddKeysToAgent yes
        IdentitiesOnly yes

    Host gitlab.com
        User git
        Hostname gitlab.com
        PreferredAuthentications publickey
        IdentityFile $HOME/.ssh/git
        AddKeysToAgent yes
        IdentitiesOnly yes

    " >> $HOME/.ssh/config;
fi;
