# Dotfiles for VS Code
---
## Installation

Firstly, you need to clone this repository to your local machine. After that you can start installation.

### Windows 10/11

#### Automatic installation via the script

To install this config you need to launch `PowerShell` as the Administrator and change directory to cloned repository because the script modifies a protected directory:

```powershell
cd "C:\your\path\to\cloned\repo"
```

Before run we must temporarily change execution policy for this `PowerShell` proccess:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Now you can **launch** the *script*:

```powershell
.\scripts\windows\install.ps1
```

Now you can always pull the latest changes for this repository and you will immediately see changes in your editor without any additional manipulations.
**Attention**: script automatically install all extensions from the list [extensions.txt](vscode/extensions.txt). The script **doesn't uninstall** your current extensions!

This script creates symlinks to these configs and snippets folder.

#### Manual installation

Press buttons `Win+R` and run next command: `%appdata%`.
Now you need to open this path: `%APPDATA%\Code\User\`.
Here you can save your config files like `settings.json`, `snippets` and `keybindings.json` somewhere and just put here **files** and **directory** from this repository (they have the same names).
Now you can use this configuration!

*Additional information*: you need to manually install all extensions from this list [extensions.txt](vscode/extensions.txt). Some extensions you need because they are used in [settings.template.json](vscode/settings.template.json) like **teabyii.ayu** for visual style and **thang-nm.flow-icons** for icons.

### Linux

*Coming soon*

#### Automatic installation via the script

*Coming soon*

#### Manual installation

*Coming soon*

---
## Git Hooks

This repository includes a `pre-commit` hook that automatically exports your installed VS Code extensions to [extensions.txt](vscode/extensions.txt) before every commit.

Hooks are not cloned automatically, so after cloning the repository you need to enable it **once**:

```bash
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
```

That's it — from now on, every commit will keep [extensions.txt](vscode/extensions.txt) up to date automatically.

---
## Extensions

You can see all extensions in this file: [extensions.txt](vscode/extensions.txt). One extension `thang-nm.flow-icons` requires a license key. This setting will be in your future [settings.json](vscode/settings.json) file.

---
## Custom shortcuts:

| Shortcut |      Command      |
|----------|:-----------------:|
| Alt+F11  |   Opens zen mode  |

---