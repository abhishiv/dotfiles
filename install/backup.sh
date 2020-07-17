#!/usr/bin/env bash
INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Backup up current files.$(tput sgr 0)"
echo "---------------------------------------------------------"

# Backup files that are provided by the Jarvis into a ~/$INSTALLDIR-backup directory
BACKUP_DIR=$INSTALLDIR/backup

set -e # Exit immediately if a command exits with a non-zero status.

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Creating backup directory at $BACKUP_DIR.$(tput sgr 0)"
echo "---------------------------------------------------------"
mkdir -p $BACKUP_DIR

files=("$HOME/.config/nvim")
for filename in "${files[@]}"; do
    if [ ! -L $filename ]; then
      echo "---------------------------------------------------------"
      echo "$(tput setaf 2) Backing up $filename.$(tput sgr 0)"
      echo "---------------------------------------------------------"
      mv $filename $BACKUP_DIR 2>/dev/null
    else
      echo "---------------------------------------------------------"
      echo -e "$(tput setaf 3) $filename does not exist at this location or is a symlink.$(tput sgr 0)"
      echo "---------------------------------------------------------"
    fi
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Backup completed.$(tput sgr 0)"
echo "---------------------------------------------------------"
