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

msg "Beginning CafeVim installation..."
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

# Clone CafeVim repository
msg "Cloning CafeVim repository..."
clone_repository "$BRANCH" "https://github.com/s-waite/CafeVim.git" "$NEOVIM_CONFIG_DIR"
msg "CafeVim repository cloned successfully."

# Install Packer plugins without having to open NeoVim
nvim -u ~/.config/nvim/utils/first_install.lua --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c "TSInstallSync java bash dockerfile fish gitcommit gitignore json kotlin markdown_inline mason sql toml vim yaml" -c q
nvim --headless -c "MasonInstall stylua" -c q

# Install Java language server
jdtls_dir="$HOME/.local/share/nvim/java-language-server"
mkdir "$jdtls_dir"
cd "$jdtls_dir"
wget -O java-language-server "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz"
tar -xzf ./java-language-server
rm -r ./java-language-server

msg "Installation finished!"
