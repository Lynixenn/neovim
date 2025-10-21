return {
    display = "Git Helpers (Gitsigns and a Graphical Git Helper (Neogit))",
    plugins = {
        -- Diffview: Enhanced diff and merge tool
        {
            "sindrets/diffview.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            cmd = {
                "DiffviewOpen",
                "DiffviewClose",
                "DiffviewToggleFiles",
                "DiffviewFocusFiles",
                "DiffviewFileHistory"
            },
            keys = {
                { "<leader>dv", "<cmd>DiffviewOpen<cr>",          desc = "Open Diffview" },
                { "<leader>dc", "<cmd>DiffviewClose<cr>",         desc = "Close Diffview" },
                { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
            },
            opts = {
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                    },
                },
            },
        },

        -- Neogit: Lazygit Alternative, this one is fully neovim-native
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
            cmd = "Neogit",
            keys = {
                { "<leader>g", "<cmd>Neogit<cr>", desc = "Neogit" }
            },
            opts = {
                integrations = {
                    diffview = true
                }
            },
        },

        -- Gitsigns: Git helper and change highlighting
        {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("gitsigns").setup({
                    current_line_blame = true,
                    current_line_blame_opts = {
                        delay = 0,
                        virt_text_pos = "eol",
                    },
                })
            end,
        },
    }
}