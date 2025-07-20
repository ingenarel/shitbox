command -v clang > /dev/null 2>&1 && export CC=clang || (command -v gcc > /dev/null 2>&1 && export CC=gcc)
if [ "$CC" = "clang" ]; then
    export CFLAGS="-Wall -Wextra -Wshadow -Wconversion -Wformat=2 -Winline -Wundef\
        -Wpointer-arith -Wpedantic -Wstrict-aliasing -Wcast-align -march=native\
        -fsafe-buffer-usage-suggestions -Winvalid-constexpr\
        -mtune=native -O2"
elif [ "$CC" = "gcc" ]; then
    export CFLAGS="-Wall -Wextra -Wshadow -Wconversion -Wformat=2 -Winline -Wunsafe-loop-optimizations -Wundef\
        -Wpointer-arith -Wpedantic -Wstrict-aliasing -Wcast-align -march=native\
        -mtune=native -O2"
else
    export CFLAGS="-Wall -Wextra -march=native -mtune=native -O2"
fi
export EDITOR="/usr/bin/env nvim"
export FZF_DEFAULT_OPTS="--bind=alt-n:down,alt-p:up"
export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'

export DEPS_SCRIPT_GENTOO_REPO="ingenarel/gentoo"
export DEPS_SCRIPT_GURU_REPO="ingenarel/guru-depfiles"
