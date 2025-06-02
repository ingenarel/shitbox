### if you're not me then it's probably best if you don't start using it outright. cz i tinker with shit a lot and push commits without testing them out **sometimes** :)
### this config works for me in both linux and windows, haven't checked bsd or mac tho.

if someone doesn't know how nvim or lua works, they are probably gonna have a bad time figuring out this config, but if
you know the basic stuff and the configuring, you can probably figure it out.

## notes for people who're not me:

### requirements for this config:
 - nodejs
 - python
 - pip
 - ripgrep
 - nerdfonts 
 - a terminal with truecolor support. i use kitty in linux and windows terminal preview in windows
 - yazi (for some keybinds i use the yazi file manager)
 - lazygit (for the git helper, i use lazygit)


### installation
- make sure that you don't have a nvim directory in your config. and if you do, rename or delete it to something.
- clone this repo. you can also download the zip and extract the file in the config
    - for noobs, you need to clone this repo as `nvim`, you can do it by doing `git clone
        https://github.com/ingenarel/nvim-config.git nvim`
- install [lazy.nvim](https://github.com/folke/lazy.nvim)
- run `COQdeps` if it tells you to.
- if running for the first time, mason should start to install the language servers. run `:Mason` to see the process.
- after doing everything, hit F5 to install and/or update everything else that's needed


### notes:
- a considerable ammount of people dislike my neon cyberpunk style theme. i love it, if you don't like it, good for you.
- i couldn't figure out how to make codelldb stop at the breakpoints in windows. or maybe i'm just dumb.
- you can update the stuff by just hitting F5
- keybindings:
    - space is used as the leader key
    - i usually map my right alt key to <ESC>, and caps lock to ctrl. on windows, i use powertoys, on linux i used keyd.
    - mapped a lot of ctrl keybindings to alt bindings. those still work with ctrl tho. so no worries.
    - you can find all the keybindings and remaps that i made in `lua/configs/keybinds`
- `textwidth` is set to 120, that means after 120 chars, you start writing from a newline, if you still couldn't
  complete a line after 120 chars, then either you have a skill issue, or you need to reset it to 0. you can also do a
  temporary fix by just doing J at the line to join the two lines.
- you probably don't need the `coq-user-snippets` directory.
