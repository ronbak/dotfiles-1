# @jonscottclark's dotfiles

Note: This repo hasn't been tailored to be un-opinionated and customizable, so I apologize if it takes some effort to customize it to your exact needs and preferences. At the very least, I hope you can find some inspiration here towards the development of your own dotfiles and configuration layout.

## Setup

Run the `bootstrap.sh` script to back up your current dotfiles and move everything in this repo to your home directory. Any dotfiles that will be overwritten will be moved to a timestamped folder in `~/.dotfiles-backup`.

## Prerequisites

- [Git](https://git-scm.com) (installed via package manager)
- [tree](http://mama.indstate.edu/users/ice/tree) (installed via package manager)
- [nvm](https://github.com/creationix/nvm), along with a stable version of Node.js (at time of writing, 0.10.x)
- [rvm](https://rvm.io), along with a stable version of Ruby (at time of writing, 2.2.2)
- [Composer](http://getcomposer.org) (optional)
- (OSX only) [Sublime Text](https://www.sublimetext.com) as the primary editor, with the `subl` [command-line helper](https://google.com/#q=subl+command+line) configured

### zsh

These dotfiles assume [zsh](https://en.wikipedia.org/wiki/Z_shell) will be used as the default shell. **Oh My Zsh** is used for configuration and customization and is included as a submodule.

To install Zsh, use [Homebrew](http://brew.sh) (OSX) or `apt-get` / `yum` (Debian / Red Hat).

Once completed, add the zsh binary to your `/etc/shells` file:

``$ echo `which zsh` >> /etc/shells``

Change the shell:

``$ chsh -s `which zsh` ``

When loading a new shell session, your `~/.zshrc` file will be loaded and will source the oh-my-zsh initialization script: initializing some things, loading plugins, and setting the Zsh theme.

## OSX Apps and Settings

Instead of including any and all kinds of resources that aid in the setup of a new Mac environment, I created another repository for that purpose called [setupfiles](https://github.com/jonscottclark/setupfiles).

## Acknowledgments

I couldn't have done this without the help of others, see [CREDITS.txt](https://github.com/jonscottclark/dotfiles/blob/master/CREDITS.txt).