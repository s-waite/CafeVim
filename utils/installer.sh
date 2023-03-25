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
NEOVIM_SHARE_DIR="$HOME/.local/share/nvim"
BRANCH="$1"

msg "Beginning LoboVim installation..."
# remove current neovim config and share directories so that we can start with a clean slate
if [ -d "$NEOVIM_CONFIG_DIR" ] || [ -d "$NEOVIM_SHARE_DIR" ]; then
  if confirm "Are you sure you want to delete your Neovim configuration and share directories?"; then
    if [ -d "$NEOVIM_CONFIG_DIR" ]; then
      msg "Deleting Neovim configuration directory..."
      rm -rf "$NEOVIM_CONFIG_DIR"
      msg "Neovim configuration directory deleted successfully."
    fi
    if [ -d "$NEOVIM_SHARE_DIR" ]; then
      msg "Deleting Neovim share directory..."
      rm -rf "$NEOVIM_SHARE_DIR"
      msg "Neovim share directory deleted successfully."
    fi
  else
    msg "Aborting. Neovim configuration and share directories not deleted."
    exit 1
  fi
else
  msg "Nothing was deleted. Neovim configuration and share directories not found."
fi

# Clone LoboVim repository
msg "Cloning LoboVim repository..."
clone_repository "$BRANCH" "https://github.com/s-waite/LoboVim.git" "$NEOVIM_CONFIG_DIR"
msg "LoboVim repository cloned successfully."

# Install Packer plugins without having to open NeoVim
nvim -u ~/.config/nvim/utils/first_install.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c "TSInstallSync all" -c q
msg "Installation finished!"

