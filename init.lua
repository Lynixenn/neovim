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

-- Leader Key
vim.g.mapleader = " "

-- UI
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%s%l  "
vim.opt.title = true
vim.opt.fillchars = {
    vert = " ",
    vertleft = " ",
    vertright = " ",
    verthoriz = " ",
}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.inccommand = "split"

-- Tabs / Indenting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.gdefault = true

-- Window
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.winborder = "none"

-- General
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 150
vim.opt.autowriteall = true
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'D', '"_D', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { noremap = true })

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
        "nvim-mini/mini.nvim",
        version = false,
        event = "VeryLazy",
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
        config = function()
            require("mini.pairs").setup()
            require("mini.comment").setup()
            require("mini.surround").setup()
            require("mini.bufremove").setup()
            require("mini.statusline").setup()
            require("mini.icons").setup()
            require("mini.notify").setup({
                lsp_progress = {
                    enable = false,
                },
            })
            vim.notify = require("mini.notify").make_notify()
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
        event = "LspAttach",
        opts = {
            progress = {
                display = {
                    done_icon = "✔",
                    progress_icon = { "dots" },
                },
            },
            notification = {
                override_vim_notify = false,
                filter = vim.log.levels.INFO,
                window = {
                    winblend = 1,
                    border = "none",
                    relative = "editor",
                },
            },
        },
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

    -- Neotree: Filetree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        opts = {
            window = {
                position = "right",
            },
            close_if_last_window = true,
            popup_border_style = "solid",
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
            },

        },
    },

    -- barbar: Tabline plugin
    {
        'romgrk/barbar.nvim',
        event = "VeryLazy",
        dependencies = {
            'lewis6991/gitsigns.nvim',
            -- No nvim-web-devicons needed
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            minimum_padding = 2,
            maximum_padding = 4,
        },
    },


    -- Todo-comments: Highlight comments
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    },

    -- Telescope: Picker UI
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-ui-select.nvim",
                config = function()
                    require("telescope").load_extension("ui-select")
                end,
            },
        },
        cmd = "Telescope",
        opts = {
            defaults = {
                border = false,
            },
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

    -- Which-key: Keymap helper
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                delay = 0,
            })
        end,
    },
}

-- Load addon plugins
local addon_names = { "lsp", "compiler", "rust", "java", "typst", "code-extras", "git", "markdown", "theme", "flash" }
for _, addon_name in ipairs(addon_names) do
    local ok, addon_plugins = pcall(load_addon, addon_name)
    if ok and addon_plugins then
        for _, plugin in ipairs(addon_plugins) do
            table.insert(plugins, plugin)
        end
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
    -- ++++++ `Basic editor commands
    { "<Esc>",      "<cmd>nohlsearch<cr>",                              desc = "Clear search highlight",     mode = "n" },

    -- Moving lines up and down
    { "<A-j>",      ":m .+1<CR>==",                                     desc = "Move line up",               mode = "n" },
    { "<A-k>",      ":m .-2<CR>==",                                     desc = "Move line down",             mode = "n" },
    { "<A-j>",      ":m '<-2<CR>gv=gv",                                 desc = "Move selection down",        mode = "v" },
    { "<A-k>",      ":m '>+1<CR>gv=gv",                                 desc = "Move selection up",          mode = "v" },

    -- Indenting Lines
    { "<",          "<gv",                                              desc = "Indent left and re-select",  mode = "v" },
    { ">",          ">gv",                                              desc = "Indent right and re-select", mode = "v" },

    -- ====== Basic editor commands


    -- File explorer Group
    { "<leader>e",  group = "Filetree" },
    -- { "<leader>ee", "<cmd>Otree<CR>",                                   desc = "Toggle Filetree",            mode = "n" },
    -- { "<leader>ef", "<cmd>OtreeFocus<CR>",                              desc = "Focus Filetree",             mode = "n" },
    { "<leader>ee", "<cmd>Neotree toggle<CR>",                          desc = "Toggle Filetree",            mode = "n" },
    { "<leader>ef", "<cmd>Neotree focus<CR>",                           desc = "Focus Filetree",             mode = "n" },

    -- Find group (Telescope)
    { "<leader>f",  group = "Find" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find files",                 mode = 'n' },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                     desc = "Live grep",                  mode = 'n' },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Find buffers",               mode = 'n' },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",                     desc = "Help tags",                  mode = 'n' },

    -- Buffer group
    { "<leader>b",  group = "Buffer" },
    { "<leader>bd", function() require("mini.bufremove").delete() end,  desc = "Delete buffer",              mode = "n" },

    -- Terminal group
    { "<leader>t",  group = "Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Vertical Terminal" },
    { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Floating Terminal" },

    -- UI group
    { "<leader>u",  group = "UI" },

    -- Addons menu
    { "<leader>a",  function() require("addons.menu").show() end,       desc = "Toggle Addons",              mode = "n" },
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
