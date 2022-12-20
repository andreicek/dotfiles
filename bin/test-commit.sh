#!/usr/bin/env sh

git diff-tree --no-commit-id --name-only -r $1 | grep exs | xargs -n1 mix test | tee "/tmp/$1.log"
