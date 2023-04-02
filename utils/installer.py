from pathlib import Path
from rich.console import Console
from rich.prompt import Prompt
import os
import shutil
import subprocess

# Use console from rich library for colored output
console = Console()

def confirm(question):
    while True:
        answer = Prompt.ask(question, choices=["y", "n"], default="n", show_choices=True)
        if answer in {"y", "n"}:
            return answer == "y"
        console.print("Please answer [y]es or [n]o.")


def clone_repository(branch, repo_url, dest_dir):
    if subprocess.call(["git", "clone", "-b", branch, repo_url, dest_dir]) != 0:
        console.print("Failed to clone repository.")
        exit(1)

# Setup directory names and colors
home_dir = Path.home()
neovim_config_dir = home_dir / ".config/nvim"
neovim_share_dir = home_dir / ".local/share/nvim"
branch = "main"
info_style = "bold blue"
success_style = "bold green"
error_style = "bold red"
progress_style = "bold yellow"

# Start the installation process
console.print("\n", end="")
console.print("Beginning CafeVim installation...", style=info_style)

# If any neovim files exist, ask to delete them. If user declines exit install
if neovim_config_dir.exists() or neovim_share_dir.exists():
    if confirm("Are you sure you want to delete your Neovim configuration and share directories?"):
        for directory in [neovim_config_dir, neovim_share_dir]:
            if directory.exists():
                console.print(f"Deleting {directory}...")
                shutil.rmtree(directory)
                console.print(f"{directory} deleted successfully.")
    else:
        console.print(
            "Aborting. Neovim configuration and share directories not deleted.", style=error_style
        )
        exit(1)
else:
    console.print(
        "Nothing was deleted. Neovim configuration and share directories not found. Continuing installation",
        style=info_style,
    )

# Clone CafeVim repo
console.print("Cloning CafeVim repository...", style=info_style)
clone_repository(branch, "https://github.com/s-waite/CafeVim.git", str(neovim_config_dir))
console.print("CafeVim repository cloned successfully.", style=success_style)

console.print("Performing first-time setup", style=progress_style)

console.print("Installing plugins, please wait", style=progress_style)
subprocess.call(
    [
        "nvim",
        "-u",
        "~/.config/nvim/utils/first_install.lua",
        "--headless",
        "-c",
        "autocmd User PackerComplete quitall",
        "-c",
        "PackerSync",
    ],
    stdout=subprocess.DEVNULL,
)
console.print("Success!", style=success_style)
print()

console.print("Installing TreeSitter parsers, please wait", style=progress_style)
subprocess.call(
    [
        "nvim",
        "--headless",
        "-c",
        "TSInstallSync java bash dockerfile fish gitcommit gitignore json kotlin markdown_inline mason sql toml vim yaml",
        "-c",
        "q",
    ],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL,
)
console.print("Success!", style=success_style)
print()

console.print("Installing formatting providers, please wait", style=progress_style)
subprocess.call(["nvim", "--headless", "-c", "MasonInstall stylua black", "-c", "q"])
print()
console.print("Success!", style=success_style)
print()

# Download the eclipse java language server, for use with the jdtls plugin
if confirm(
    "Would you like to install the Eclipse Java language server? If not, you will have to do this manually (see the nvim-jdtls plugin)"
):
    jdtls_dir = neovim_share_dir / "java-language-server"
    jdtls_dir.mkdir(exist_ok=True)
    os.chdir(jdtls_dir)
    subprocess.call(
        [
            "wget",
            "-O",
            "java-language-server",
            "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz",
        ]
    )
    subprocess.call(["tar", "-xzf", "java-language-server"])
    subprocess.call(["rm", "-r", "java-language-server"])

console.print("Installation finished!", style=success_style)
