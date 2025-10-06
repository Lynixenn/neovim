# Neovim Configuration

A simple and modular Neovim configuration written in Lua.

## Installation

1. Backup your existing Neovim configuration:

    mv ~/.config/nvim ~/.config/nvim.backup

2. Clone this repository:

    git clone https://github.com/Lynixenn/neovim.git ~/.config/nvim

3. Open Neovim:

    nvim

## Structure

The configuration is organized in a modular structure for easy maintenance:

    ~/.config/nvim/
    ├── init.lua          # Entry point
    ├──── lua/              # Lua modules
    ├────── addons/
    └──────── modules/

## Requirements

- Neovim 0.11 or later
- Git
