# @jonscottclark's dotfiles

These dotfiles help configure the [friendly interactive shell (fish)](https://github.com/fish-shell/fish-shell).

Also included is a global `.gitignore` and a `.gitconfig` (if forking, please change to your own user name and e-mail).

---

### the friendly interactive shell (fish)

Before using these dotfiles, you need to be using `fish` as your shell. You'll enjoy it, seriously!

Install the **fish** package via [Homebrew](http://brew.sh) (OSX), `apt-get` / `yum` (Debian / Red Hat), or whatever you use; you know best.

Once completed, ensure its path is added the `/etc/shells` file. Usually a package manager will do this for you, but it's good to double-check. (Get the path by typing `which fish` in the terminal).

Change the shell:

``$ chsh -s `which fish` ``

#### oh-my-fish

[Oh My Fish](https://github.com/bpinto/oh-my-fish) is used to manage themes and plugins.

After **fish** has installed, grab **oh-my-fish** as well:

`$ curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish`

---

### Good things to have

These dotfiles make use of the following tools, so if you want everything to work out of the box, you ought to have these:

- [git-flow](https://github.com/nvie/gitflow)
- [nvm](https://github.com/creationix/nvm) (install a version of Node.js/io.js and then set it as the default version to use, e.g. `nvm alias default 0.10`)
- [Sublime Text](https://www.sublimetext.com) as the primary editor (OSX only)
- [tree](http://mama.indstate.edu/users/ice/tree)
- [z](https://github.com/rupa/z) (installed (or symlinked) to `/usr/local/etc/profile.d/z.sh`)

---

### Ok, let's go!

`$ . bootstrap.fish`

- Checks for dependencies
- Backs up anything due to be replaced to a dated folder in `~/dotfiles-backup`
- Copies these dotfiles to your home directory

---

### OSX Settings?

Instead of including any and all kinds of resources that aid in the setup of a new Mac environment, I created another repository for that purpose called [setupfiles](https://github.com/jonscottclark/setupfiles). There, you'll find settings for Sublime Text, iTerm, and OSX itself.

---

### Credits

I greatly relied on the existing work of other developers, please see [CREDITS.txt](https://github.com/jonscottclark/dotfiles/blob/master/CREDITS.txt).

### Licenses

[MIT License](http://jonscottclark.mit-license.org/) © Jon Scott Clark

[MIT License](https://github.com/mathiasbynens/dotfiles/blob/master/LICENSE-MIT.txt) © Mathias Bynens