local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load core modules
require("core.options")

local addon_state = require("addons.state")

-- Dynamic Addon plugin loader
local function load_addon_plugins(plugins_table)
    local addon_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/addons/modules", "*.lua", true, true)

    for _, file_path in ipairs(addon_files) do
        local addon_name = vim.fn.fnamemodify(file_path, ":t:r")
        if addon_state.is_enabled(addon_name) then
            local ok, addon_config = pcall(require, "addons.modules." .. addon_name)
            if ok and addon_config and addon_config.plugins then
                for _, plugin in ipairs(addon_config.plugins) do
                    table.insert(plugins_table, plugin)
                end
            else
                vim.notify("Failed to load addon: " .. addon_name, vim.log.levels.ERROR)
            end
        end
    end
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
            require("mini.comment").setup()
            require("mini.bufremove").setup()
            require("mini.icons").setup()
            require("mini.notify").setup({
                lsp_progress = {
                    enable = false,
                },
            })
            vim.notify = require("mini.notify").make_notify()
        end,
    },

    -- Lualine: Statusline Plugin. Minimal configuration
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            extensions = { "neo-tree", "overseer", "lazy", "toggleterm", "mason" }
        },
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

load_addon_plugins(plugins)
require("lazy").setup(plugins)
require("core.keymaps")
