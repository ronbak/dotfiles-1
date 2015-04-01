# @jonscottclark's dotfiles

Note: This repo hasn't been tailored to be un-opinionated and customizable, so I apologize if it takes some effort to customize it to your exact needs and preferences. At the very least, I hope you can find some inspiration here towards the development of your own dotfiles and configuration layout.

## Prerequisites

- [Homebrew](http://brew.sh)
- [Git](https://git-scm.com) (installed via Homebrew, ideally)
- [tree](https://brewformulas.org/Tree) (installed via Homebrew)
- [nvm](https://github.com/creationix/nvm), along with a stable version of Node.js (0.10.x)
- [rvm](https://rvm.io), along with a stable version of Ruby (2.1.1)
- [Sublime Text](https://www.sublimetext.com) as the primary editor, with the `subl` [command-line helper](https://google.com/#q=subl+command+line) configured

### Zsh

These dotfiles assume [Zsh](https://en.wikipedia.org/wiki/Z_shell) will be used as the default shell. **Oh My Zsh** is used for configuration and customization and is included as a submodule.

To install Zsh, use Homebrew:

`$ brew install zsh`

Then add the following line to your `/etc/shells` file:

`/usr/local/bin/zsh`

Change the shell:

`$ chsh -s /usr/local/bin/zsh`

When loading a new shell, your `~/.zshrc` file will be loaded and will source the oh-my-zsh setup script: initializing some things, loading plugins, and setting the Zsh theme.

## Setup

Run the `bootstrap.sh` script to back up your current dotfiles and move everything in this repo to your home directory. Any dotfiles that will be overwritten will be sent to a timestamped folder in `~/.dotfiles-backup`.

## OSX Apps and Settings

Instead of including any and all kinds of resources that aid in the setup of a new Mac environment, I created another repository for that purpose called [setupfiles](https://github.com/jonscottclark/setupfiles).

## Acknowledgments

I couldn't have done this without the help of others, see [CREDITS.txt](https://github.com/jonscottclark/dotfiles/blob/master/CREDITS.txt).