#!/usr/bin/env bash

export BORG_PASSPHRASE=$1

echo "Starting backup..."

borgmatic \
  --config ~/.dotfiles/borgmatic.yaml \
  -v 1

powershell.exe -command New-BurntToastNotification -Text "Backup!"
echo "Backup ended..."
