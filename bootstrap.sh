#!/bin/bash

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# Notice title
notice() { echo; echo  "=> $1"; }

# Error title
error() { echo; echo "=> Error: $1"; }

# List item
c_list() { echo  "  ✔ $1"; }

# Error list item
e_list() { echo  "  ✖ $1"; }

# Check for dependencies
dep() {
  if [ "$1" == "nvm" ]; then
    if [ -d "$HOME/.nvm" ]; then
      local installed=0
    else
      local installed=1
    fi
  else
    type $1 &> /dev/null
    local installed=$?
  fi

  if [ $installed -eq 0 ]; then
    c_list $1
  else
    e_list $1
  fi
  return $installed
}

backup() {
  mkdir -p $backupdir

  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}"
    should_copy=$?
    if [ $should_copy -gt 0 ]; then
      [ -f "$HOME/$file" ] && cp -Rf "$HOME/$file" "$backupdir/$file"
    fi
  done
}

install() {
  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}"
    should_install=$?
    if [ $should_install -gt 0 ]; then
      [ -d "$HOME/$file" ] && rm -rf "$HOME/$file"
      cp -Rf "$file" "$HOME/$file"
      c_list $file
    fi
  done
}

in_array() {
  local hay needle=$1
  shift
  for hay; do
    [[ $hay == $needle ]] && return 0
  done
  return 1
}


#-----------------------------------------------------------------------------
# Initialize
#-----------------------------------------------------------------------------

backupdir="$HOME/.dotfiles-backup/$(date "+%Y-%m-%d-%H%M.%S")"
dependencies=(brew git nvm rvm tree)
excluded=(. .. .DS_Store .git .gitignore .gitmodules bootstrap.sh CREDITS.txt LICENSE-MIT.txt README.md)


#-----------------------------------------------------------------------------
# Dependencies
#-----------------------------------------------------------------------------

notice "Checking dependencies"

not_met=0
for need in "${dependencies[@]}"; do
  dep $need
  met=$?
  not_met=$(echo "$not_met + $met" | bc)
done

if [ $not_met -gt 0 ]; then
  error "$not_met dependencies not met!"
  exit 1
fi


#-----------------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------------

# Assumes $HOME/.dotfiles is *ours*
if [ -d $HOME/.dotfiles ]; then
  pushd $HOME/.dotfiles > /dev/null

  # Update Repo
  notice "Updating this repository + the oh-my-zsh submodule"
  git pull origin master
  git submodule init
  git submodule update --remote --merge

  # Get oh-my-zsh plugins
  notice "Grabbing oh-my-zsh plugins"
  pushd $HOME/.dotfiles/.oh-my-zsh/custom/plugins > /dev/null
  [ -d "$HOME/.dotfiles/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] || git clone -q git://github.com/zsh-users/zsh-syntax-highlighting.git
  [ -d "$HOME/.dotfiles/.oh-my-zsh/custom/plugins/git-flow-completion" ] || git clone -q git://github.com/bobthecow/git-flow-completion.git
  popd > /dev/null

  # Get oh-my-zsh theme
  notice "Grabbing zsh theme"
  mkdir -p $HOME/.dotfiles/.oh-my-zsh/custom/themes
  pushd $HOME/.dotfiles/.oh-my-zsh/custom/themes > /dev/null
  [ -f "$HOME/.dotfiles/.oh-my-zsh/custom/themes/jonscottclark.zsh-theme" ] || git clone -q git://github.com/jonscottclark/jonscottclark.zsh-theme.git .
  popd > /dev/null
else
  # Clone Repo
  notice "Downloading"
  git clone --recursive git://github.com/jonscottclark/dotfiles.git $HOME/.dotfiles

  pushd $HOME/.dotfiles > /dev/null
fi

# Backup
notice "Backup up old files ($backupdir)"
backup

# Install
notice "Installing"
install

#-----------------------------------------------------------------------------
# Finished
#-----------------------------------------------------------------------------

popd > /dev/null
notice "Done! Reloading shell..."
echo
exec $SHELL -l