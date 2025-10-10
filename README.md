Simple, Personal Neovim configuration

## Installation

1. Backup your existing Neovim configuration:

    mv ~/.config/nvim ~/.config/nvim.backup

2. Clone this repository:

    git clone https://github.com/Lynixenn/neovim.git ~/.config/nvim

3. Open Neovim:

    nvim

## Structure

The configuration is organized in a modular structure for easy maintenance, focusing on Simple things like:
- Syntax highlighting
- A Theme
- Speed
- Minimality

To Accomplish this, the basic Configuration is kept simple, working through an "Addon" System instead.
File-specific keybinds are always bound as a group to `<leader>y` to simplify the keybind structure.

Both Typst, LaTeX, C, C++ and Rust might work with `<leader>y`, but the keybinds will have a different functionality buffer to buffer.

## Requirements

- Neovim 0.11 or later
- Git
