# fish settings
set --erase fish_greeting
set fish_path $HOME/.oh-my-fish
set fish_custom $HOME/.config/fish

# exports
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set HISTSIZE 32768
set HISTFILESIZE 32768
set -x HISTCONTROL ignoreboth

# load oh-my-fish
. $fish_path/oh-my-fish.fish

# theme
Theme "clearance"

# plugins
Plugin "theme"
Plugin "gi"
Plugin "git-flow"
Plugin "rvm"
Plugin "z"

# os-specific configs
set -l platform_file $fish_custom/platforms/(uname -s).fish
if test -f $platform_file
  . $platform_file
end

# navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function l     ; tree --dirsfirst -aFCNL 1 $argv ; end
function ll    ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

# utilities
function a        ; command ag --ignore=.git --ignore=log --ignore=tags --ignore=tmp --ignore=vendor --ignore=spec/vcr $argv ; end
function d        ; du -h -d=1 $argv ; end
function digga    ; command dig +nocmd $argv[1] any +multiline +noall +answer; end
function g        ; git $argv ; end
function ip       ; curl -s http://icanhazip.com/ ; end
function mkcd     ; mkdir $argv ; and cd $argv ; end
function sudo!    ; echo "sudo $history[1]" ; eval sudo $history[1]; end

# completions
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

make_completion g 'git'
make_completion n 'npm'