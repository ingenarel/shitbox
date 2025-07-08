# What is Shitbox?

It's a \<distro independent\>? setup for my system(s)

# Why Shitbox?

Vanilla arch is too boring, i got ptsd from `gcc` with `lto pgo` and `node` with `npm` USE flags for gentoo, and nix
fucking sucks ass and i hate it even tho i have used it for a while.

# Is it a new linux distro?

Not yet, atm, it will be just a port of my nixos-config to bash so i need to write a shitload of scripts, i will use
gentoo with this in qemu and probably arch as my main system

# Should i use it?

I don't think so, if you don't want a setup that's fully like mine, then don't. The scripts aren't hand holding and
wouldn't probably be idiot proof too. And i don't like to write comments that much and explain stuff

# Will you make this a portable new package manager / distro?

If i need to, yes. If i don't, then no. I don't care about you

# Why won't you hold my hand?

Because i'm not interested in a relationship

# Why bash?

Because i fucking can! I previously thought about using lua but bash is on like most linux distro isos, so bash it is

# Why not ansible or guix or this and that?

My fucking wish

# Quick install:

### Arch:
`pacman -Sy && pacman -S git && git clone https://github.com/ingenarel/shitbox.git && cd shitbox && ./setup.sh sda sda1 mbr`

### Gentoo:
`git clone https://github.com/ingenarel/shitbox.git && cd shitbox && ./setup.sh sda sda1 mbr`
