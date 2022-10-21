#!/bin/bash
set -eufo pipefail

commands=(
    PlugUpgrade
    PlugClean!
    PlugUpdate
)
for cmd in ${commands[@]}; do
    echo "nvim: $cmd"

    result=$(nvim --headless +"$cmd" +qa 2>&1)

    if [[ $result == *"Error"* ]]; then
        echo "$result"
        exit 1
    fi
done
