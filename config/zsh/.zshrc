# zsh
HISTFILE=$XDG_STATE_HOME/zsh/history

# Homebrew completions
# Note: If I switch to Oh My Zsh, I'll need to move FPATH to ~/.zprofile and
# allow Oh My Zsh to handle calling compinit for me. See the homebrew docs.
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

##
# Pyenv
#

# Pyenv environment
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Build python with shared object support
export PYTHON_CONFIGURE_OPTS="--enable-shared"

# Avoid collisions between Homebrew and Pyenv environments
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

##
# Perl
#

# From Homebrew: By default non-brewed cpan modules are installed to the Cellar. If
# you wish for your modules to persist across updates we recommend using `local::lib`.
eval "$(perl -I$XDG_DATA_HOME/perl5/lib/perl5 -Mlocal::lib=$XDG_DATA_HOME/perl5)"

##
# Path configuration
#

export PATH="$XDG_DATA_HOME/npm/bin:${PATH}"
export PATH="$XDG_BIN_HOME:${PATH}"

##
# Aliases
#

alias ls='ls -alhG'

alias vi='nvim'
alias vim='nvim'

alias cdcg='cd ~/code/github'
alias cdcn='cd ~/code/github/nelgau'

alias sm='ssh maxwell'

##
# Convenience functions
#

# Clone a Github repository to "~/Code/[username]/[repo]"
function gitc() {
  local remote=$1
  local repo_path=$(echo "$remote" | awk -F ':|\/|[\.]git' '{ print $2 "/" $3 }');
  local local_path="${HOME}/Code/$repo_path";

  mkdir -p "$local_path"
  git clone --recursive "$remote" "$local_path"
  cd "$local_path"
}

# Colors for `ls`
export LSCOLORS=Exfxbxdxcxegedabagacad

# Zsh completions
autoload -Uz compinit
compinit

##
# Python aliases
#

alias prm='poetry run python -m'

##
# Building
#

export MAKEFLAGS="-j $(sysctl -n hw.ncpu)"

