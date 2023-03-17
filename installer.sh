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
  local branch="$1"
  local repo_url="$2"
  local dest_dir="$3"

  if ! git clone -b "$branch" "$repo_url" "$dest_dir"; then
    msg "Failed to clone repository."
    exit 1
  fi
}

NEOVIM_CONFIG_DIR="$HOME/.config/nvim"
BRANCH="$1"


msg "Beginning LoboVim installation..."
# remove current neovim config directory so that we can start with a clean slate
if [ -d "$NEOVIM_CONFIG_DIR" ]; then
  if confirm "Are you sure you want to delete your Neovim configuration?"; then
    msg "Deleting Neovim configuration directory..."
    rm -rf "$NEOVIM_CONFIG_DIR"
    msg "Neovim configuration directory deleted successfully."
  else
    msg "Aborting. Neovim configuration directory not deleted."
    exit 1
  fi
else
  msg "Nothing was deleted. Neovim configuration directory not found."
fi

# Install packer
mkdir -p ~/.local/share/nvim/site/pack/packer/start/
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c "packadd packer.nvim | PackerInstall"

# Clone LoboVim repository
# msg "Cloning LoboVim repository..."
# clone_repository "$BRANCH" "https://github.com/s-waite/LoboVim.git" "$NEOVIM_CONFIG_DIR"
# msg "LoboVim repository cloned successfully."

