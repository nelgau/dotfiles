# TODO: Factor this out into file to hold all XDG basedir spec-related stuff.
# TODO: Test for environment variables before setting?
# See https://github.com/rememberYou/dotfiles/blob/master/sh/.config/sh/xdg

export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_STATE_HOME="$HOME/.local/state"

# zsh
export ZDOTDIR=$HOME/.config/zsh

# python
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export POETRY_CONFIG_DIR=$XDG_CONFIG_HOME/pypoetry
export POETRY_DATA_DIR=$XDG_DATA_HOME/pypoetry
export POETRY_CACHE_DIR=$XDG_CACHE_HOME/pypoetry

# ruby
export GEM_HOME=$XDG_DATA_HOME/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle

# rust
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo

# node
export npm_config_userconfig=$XDG_CONFIG_HOME/npm/config
export npm_config_cache=$XDG_CACHE_HOME/npm
export npm_config_prefix=$XDG_DATA_HOME/npm

# less
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_STATE_HOME/less/lesshst
