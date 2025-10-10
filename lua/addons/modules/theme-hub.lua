return {
    {
        "erl-koenig/theme-hub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("theme-hub").setup({
                install_dir = vim.fn.stdpath("data") .. "/theme-hub",
                auto_install_on_select = true,
                apply_after_install = true,
                persistent = true,
            })
            
            local wk = require("which-key")
            wk.add({
                { "<leader>ut", "<cmd>ThemeHub<cr>", desc = "Pick Theme", mode = "n" },
            })
        end,
    }
}
