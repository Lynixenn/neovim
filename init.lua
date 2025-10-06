-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.updatetime = 150
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g.mapleader = " "
vim.opt.cursorline = true
vim.opt.autowriteall = true
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

local addon_state = require("addons.state")

local function load_addon(addon_name)
    if addon_state.is_enabled(addon_name) then
        local ok, addon_plugins = pcall(require, "addons.modules." .. addon_name)
        if ok then
            return addon_plugins
        else
            vim.notify("Failed to load addon: " .. addon_name, vim.log.levels.ERROR)
        end
    end
    return {}
end

-- General/Basic Plugins
local plugins = {
    -- mini.nvim: minimal and dependency-free module suite
    {
        "echasnovski/mini.nvim",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup()
            require("mini.comment").setup()
            require("mini.surround").setup()
            require("mini.tabline").setup()
            require("mini.bufremove").setup()
            require("mini.statusline").setup()
            require("mini.icons").setup()
            require('mini.icons').mock_nvim_web_devicons()
            require("mini.cursorword").setup()
            require("mini.move").setup()
        end,
    },

    -- Indent-blankline: Indentlines with Highlighting of the current scope
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost", 
        opts = {}
    },

    -- Fidget: Nonintrusive Notification plugin
    {
        "j-hui/fidget.nvim",
        tag = "v1.6.1",
        lazy = false,
        opts = {
            progress = {
                display = {
                    done_icon = "✔",
                    progress_icon = { "dots" },
                },
            },
            notification = {
                override_vim_notify = true,
                filter = vim.log.levels.INFO,
                window = {
                    winblend = 0,
                    border = "none",
                    relative = "editor",
                },
            },
        },
    },

    -- OTree: Filetree with Oil.nvim support
    {
        "Eutrius/Otree.nvim",
        cmd = { "Otree" },
        dependencies = {
            "stevearc/oil.nvim",
            { "echasnovski/mini.icons", opts = {} },
        },
        config = function()
            require("Otree").setup({
                win_size = 40,
                open_on_left = false,
                git_signs = true,
                show_hidden = true,
                show_ignore = true,
            })
            require("oil").setup({})
        end
    },

    -- Treesitter: syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- Treesitter-Context: Show Context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = { max_lines = 4, multiline_threshold = 2 },
    },

    -- Nvim-colorizer: hex code color
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("colorizer").setup()
        end
    },

    -- Todo-comments: Highlight comments
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
        }
    },

    -- Toggleterm: terminal management
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        config = function()
            require("toggleterm").setup()
        end,
    },

    -- Gitsigns: Git helper
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 300,
                    virt_text_pos = "eol",
                },
            })
        end,
    },

    -- Which-key: Keymap helper
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                delay = 0;
            })
        end,
    },

    -- Sonokai: Monokai-pro-esque color theme
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "default"
            vim.cmd.colorscheme("sonokai")
        end
    },
}

-- Load addon plugins
local addon_names = { "lsp", "compiler", "rust", "java", "typst", "code-extras", "git-extras" }
for _, addon_name in ipairs(addon_names) do
    local addon_plugins = load_addon(addon_name)
    for _, plugin in ipairs(addon_plugins) do
        table.insert(plugins, plugin)
    end
end

-- Setup lazy.nvim with all plugins
require("lazy").setup(plugins)

-- Flash on copy/yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Auto-reload on focus/buffer switch
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
})

-- Keymaps using which-key v3
local wk = require("which-key")

wk.add({
    -- Basic editor commands
    { "<leader>w",  "<cmd>write<cr>",                                  desc = "Write file",             mode = "n" },
    { "<leader>q",  "<cmd>quit<cr>",                                   desc = "Quit",                   mode = "n" },
    { "<Esc>",      "<cmd>nohlsearch<cr>",                             desc = "Clear search highlight", mode = "n" },

    -- File explorer
    { "<leader>e",  "<cmd>Otree<CR>",                                  desc = "Toggle Filetree",        mode = "n" },

    -- Find group (mini.pick)
    { "<leader>f",  group = "Find" },
    -- { "<leader>ff", "<cmd>Pick files<cr>",                             desc = "Find files",             mode = "n" },
    -- { "<leader>fg", "<cmd>Pick grep_live<cr>",                         desc = "Live grep",              mode = "n" },
    -- { "<leader>fb", "<cmd>Pick buffers<cr>",                           desc = "Find buffers",           mode = "n" },
    -- { "<leader>fh", "<cmd>Pick help<cr>",                              desc = "Help tags",              mode = "n" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                   desc = "Find files",             mode = 'n' },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                    desc = "Live grep",              mode = 'n' },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                      desc = "Find buffers",           mode = 'n' },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",                    desc = "Help tags",              mode = 'n' },

    -- Buffer group
    { "<leader>b",  group = "Buffer" },
    { "<leader>bd", function() require("mini.bufremove").delete() end, desc = "Delete buffer",          mode = "n" },

    -- Addons menu
    { "<leader>a",  function() require("addons.menu").show() end,      desc = "Toggle Addons",          mode = "n" },
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
