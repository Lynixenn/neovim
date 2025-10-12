return {
    -- Neogit: Lazygit Alternative, this one is fully neovim-native
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("neogit").setup {}
            local wk = require("which-key")
            wk.add({
                { "<leader>g", "<cmd>Neogit<cr>", desc = "Neogit" }
            })
        end
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
