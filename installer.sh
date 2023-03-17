#!/bin/bash

function msg() {
  echo "$1"
}

function confirm() {
  local question="$1"
  while true; do
    msg "$question"
    read -p "[y]es or [n]o (default: no) : " -r answer
    case "$answer" in
      y | Y | yes | YES | Yes)
        return 0
        ;;
      n | N | no | NO | No | *[[:blank:]]* | "")
        return 1
        ;;
      *)
        msg "Please answer [y]es or [n]o."
        ;;
    esac
  done
}

function clone_repository() {
  local repo_url="$1"
  local dest_dir="$2"

  if ! git clone "$repo_url" "$dest_dir"; then
    echo "Failed to clone repository."
    exit 1
  fi
}

NEOVIM_CONFIG_DIR="$HOME/.config/nvim"

# remove current neovim config directory so that we can start with a clean slate
if [ -d "$NEOVIM_CONFIG_DIR" ]; then
  if confirm "Are you sure you want to delete your Neovim configuration?"; then
    echo "Deleting Neovim configuration directory..."
    rm -rf "$NEOVIM_CONFIG_DIR"
    echo "Neovim configuration directory deleted successfully."
  else
    echo "Aborting. Neovim configuration directory not deleted."
    exit 1
  fi
else
  echo "Nothing was deleted. Neovim configuration directory not found."
fi

# Clone LoboVim repository
echo "Cloning LoboVim repository..."
clone_repository "https://github.com/s-waite/LoboVim.git" "$NEOVIM_CONFIG_DIR"
echo "LoboVim repository cloned successfully."

