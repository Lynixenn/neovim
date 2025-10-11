-- LSP addon: Mason + LSP Config
return {
    -- Mason: LSP installer
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    -- Mason-LSPConfig bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" },
            })
        end,
    },

    -- LuaSnip: Snippet Engine
    {
        "rafamadriz/friendly-snippets",
        lazy = false,
    },

    -- Blink.cmp: Autocompletion with LuaSnip integration
    {
        "saghen/blink.cmp",
        version = '1.*',
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = {
            keymap = {
                preset = "default",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },

            sources = {
                default = { "lsp", "snippets", "path", "buffer" },
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                }
            },

            signature = {
                enabled = true,
            },
        },
    },

    -- Conform.nvim: Lightweight and quick formatter
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            format_on_save = {
                lsp_format = "prefer",
            }
        }
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "saghen/blink.cmp",
            "folke/which-key.nvim"
        },
        config = function()
            local wk = require("which-key")

            -- only when LSP attaches, add Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    wk.add({
                        { "gd",         vim.lsp.buf.definition,     desc = "Go to Definition",     buffer = ev.buf },
                        { "K",          vim.lsp.buf.hover,          desc = "Hover Documentation",  buffer = ev.buf },
                        { "gi",         vim.lsp.buf.implementation, desc = "Go to Implementation", buffer = ev.buf },
                        { "gr",         vim.lsp.buf.references,     desc = "Go to References",     buffer = ev.buf },
                        { "<leader>rn", vim.lsp.buf.rename,         desc = "Rename Symbol",        buffer = ev.buf },
                        { "<leader>ca", vim.lsp.buf.code_action,    desc = "Code Action",          buffer = ev.buf },
                    })
                end,
            })
        end,
    },
}
