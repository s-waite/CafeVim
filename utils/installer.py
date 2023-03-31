from pathlib import Path
from rich.console import Console
from rich.prompt import Prompt
import os
import shutil
import subprocess

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

home_dir = Path.home()
neovim_config_dir = home_dir / ".config/nvim"
neovim_share_dir = home_dir / ".local/share/nvim"
branch = "main"

console.print("\n", end="")
console.print("Beginning CafeVim installation...", style="bold green on blue")

if neovim_config_dir.exists() or neovim_share_dir.exists():
    if confirm("Are you sure you want to delete your Neovim configuration and share directories?"):
        for directory in [neovim_config_dir, neovim_share_dir]:
            if directory.exists():
                console.print(f"Deleting {directory}...")
                shutil.rmtree(directory)
                console.print(f"{directory} deleted successfully.")
    else:
        console.print("Aborting. Neovim configuration and share directories not deleted.")
        exit(1)
else:
    console.print("Nothing was deleted. Neovim configuration and share directories not found.")

console.print("Cloning CafeVim repository...")
clone_repository(branch, "https://github.com/s-waite/CafeVim.git", str(neovim_config_dir))
console.print("CafeVim repository cloned successfully.")

subprocess.call(["nvim", "-u", "~/.config/nvim/utils/first_install.lua", "--headless", "-c", "autocmd User PackerComplete quitall", "-c", "PackerSync"])
subprocess.call(["nvim", "--headless", "-c", "TSInstallSync java bash dockerfile fish gitcommit gitignore json kotlin markdown_inline mason sql toml vim yaml", "-c", "q"])
subprocess.call(["nvim", "--headless", "-c", "MasonInstall stylua", "-c", "q"])

jdtls_dir = neovim_share_dir / "java-language-server"
jdtls_dir.mkdir(exist_ok=True)
os.chdir(jdtls_dir)
subprocess.call(["wget", "-O", "java-language-server", "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz"])
subprocess.call(["tar", "-xzf", "java-language-server"])
subprocess.call(["rm", "-r", "java-language-server"])

console.print("Installation finished!")
