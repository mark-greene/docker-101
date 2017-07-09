#!/bin/bash
git config --global color.ui true
git config --global user.name "Mark Greene"
git config --global user.email "mark.greene@yahoo.com"
git config --global credential.helper "cache --timeout=3600"
git config --global core.editor "nano"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

exec "$@"
