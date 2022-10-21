#!/bin/bash
set -eufo pipefail

commands=(
    PlugUpgrade
    PlugClean!
    PlugUpdate
)
for cmd in ${commands[@]}; do
    result=$(nvim --headless +"$cmd" +qa 2>&1)

    if [[ $result == *"Error"* ]]; then
        echo "nvim: $cmd"
        echo "$result"
        exit 1
    fi
done
