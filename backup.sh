#!/usr/bin/env bash

echo "Starting backup..."

borgmatic \
  --config ~/.dotfiles/borgmatic.yaml \
  -v 1

powershell.exe -command New-BurntToastNotification -Text "Backup!"
echo "Backup ended..."
