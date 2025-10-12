return {
    { "bettervim/yugen.nvim",        lazy = true },
    { "Mofiqul/vscode.nvim",         lazy = true },
    { "sainnhe/sonokai",             lazy = true },
    { "EdenEast/nightfox.nvim",      lazy = true },
    { "dasupradyumna/midnight.nvim", lazy = true },
    { "bluz71/vim-moonfly-colors",   name = "moonfly", lazy = true },

    -- Themery automatically loads the active theme
    {
        "zaldih/themery.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("themery").setup({
                themes = {
                    "vscode",
                    "yugen",
                    "sonokai",
                    "carbonfox",
                    "nightfox",
                    "midnight",
                    "moonfly",
                },

                livePreview = true,
            })

            local wk = require("which-key")
            wk.add({
                { "<leader>ut", "<cmd>Themery<cr>", desc = "Theme Picker" }
            })
        end,
    },
}
