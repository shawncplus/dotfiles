My configs for vim, git, tmux, and a plethora of BASH stuff. For a general idea of what it looks like/how it acts see https://youtube.com/sabiddle

# Requirements

Depending on the install options you pick you'll need git and additionally

If you choose to install vim configs:
* Vim 7.4+ (7.3 if you don't want line numbers and relative line numbers at the same time like I do)

If you choose to install my tmux configs:
* python and pip (On Ubuntu 14.04 you may into an ImportError bug, if so see this [LaunchPad](https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991#yui_3_10_3_1_1427949292045_394) link for a workaround)
* tmux 1.9a (This will be distro dependent so you'll have to install it yourself. If you stay on 1.8 you'll get weirdness, just upgrade)

# Installing

1. Clone the repo
2. `cd` into it and run `./install`
3. It'll ask which parts you want to install (git configs, vim configs, tmux configs)
4. After it's done close your terminal and reopen it 3 times... ok, just once.
