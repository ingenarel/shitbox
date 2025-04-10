ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git --branch main --depth 1 "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
source ~/.config/zsh/plugins/fzf-tab-setup.zsh
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-syntax-highlighting
zinit load hlissner/zsh-autopair
