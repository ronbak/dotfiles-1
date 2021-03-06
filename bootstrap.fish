#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# Notice title
function notice
  echo
  echo  "=> $argv[1]"
end

# Error title
function error
  echo
  echo "=> Error: $argv[1]"
end

# List item
function c_list
  echo  "  ✔ $argv[1]"
end


# Error list item
function e_list
  echo  "  ✖ $argv[1]"
end

# Check for dependencies
function check_dep
  set -l missing 0

  type $argv[1] ^&1 > /dev/null
  set missing $status

  if [ $missing -eq 0 ]
    c_list $argv[1]
  else
    e_list $argv[1]
  end

  return $missing
end

function backup
  mkdir -p $backupdir

  set -l files (ls -a)
  for file in $files
    if not contains $file $excluded
      if [ -d "$HOME/$file" ]
        cp -Rf "$HOME/$file" "$backupdir"
      else if [ -f "$HOME/$file" ]
        cp -Rf "$HOME/$file" "$backupdir/$file"
      end
    end
  end
end

function install
  set -l files (ls -a)
  for file in $files
    if not contains $file $excluded
      if [ -d "$HOME/$file" ]
        cp -Rf "$file" "$HOME"
      else
        cp -Rf "$file" "$HOME/$file"
      end
      c_list $file
    end
  end
end


#-----------------------------------------------------------------------------
# Initialize
#-----------------------------------------------------------------------------

set backupdir $HOME/dotfiles-backup/(date "+%Y-%m-%d-%H%M.%S")
set dependencies "git" "tree"
set excluded "." ".." ".DS_Store" ".git" ".gitignore" ".gitmodules" "bootstrap.fish" "CREDITS.txt" "LICENSE-MIT.txt" "README.md"


#-----------------------------------------------------------------------------
# Dependencies
#-----------------------------------------------------------------------------

notice "Checking dependencies..."

set not_met 0

for need in $dependencies
  check_dep $need
  set not_met (math $not_met + $status)
end

if [ $not_met -gt 0 ]
  error "$not_met dependencies not met!"
  exit 1
end

#-----------------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------------

# Assumes $HOME/dotfiles is *ours*
if [ -d $HOME/dotfiles ]
  pushd $HOME/dotfiles > /dev/null

  # Update Repo
  notice "Updating this repository + submodule(s)..."
  git pull origin master
  git submodule init
  git submodule update --remote --merge

else
  # Clone Repo
  notice "Downloading..."
  git clone --recursive git://github.com/jonscottclark/dotfiles.git $HOME/dotfiles

  pushd $HOME/dotfiles > /dev/null
end

# Backup
notice "Backup up old files ($backupdir)..."
backup

# Install
notice "Installing dotfiles..."
install

#-----------------------------------------------------------------------------
# Finished
#-----------------------------------------------------------------------------

popd > /dev/null
notice "Installing Oh My Fish plugins and theme..."
. ~/.config/fish/config.fish
omf install
notice "Done! Reloading shell..."
fish

