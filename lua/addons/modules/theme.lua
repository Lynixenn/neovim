return {
    display = "VSCode theme",
    plugins = {
        -- {
        --     "sainnhe/sonokai",
        --     lazy = false,
        --     priority = 1000,
        --     config = function()
        --         -- Basic style settings
        --         vim.g.sonokai_style = "atlantis"
        --         vim.g.sonokai_enable_italic = 0
        --         vim.g.sonokai_better_performance = 1
        --
        --         -- Use background highlighting for diagnostics instead of colors
        --         vim.g.sonokai_diagnostic_text_highlight = 1
        --         vim.g.sonokai_diagnostic_virtual_text = 'highlighted'
        --
        --         -- Make current word stand out with background instead of color
        --         vim.g.sonokai_current_word = 'grey background'
        --
        --         -- Dimmed inlay hints
        --         vim.g.sonokai_inlay_hints_background = 'dimmed'
        --         vim.cmd.colorscheme("sonokai")
        --     end,
        -- },
        {
            "Mofiqul/vscode.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require('vscode').setup({
                    style = 'dark',
                    transparent = false,
                    italic_comments = true,
                    disable_nvimtree_bg = true,
                })
                vim.cmd.colorscheme("vscode")
            end,
        },
    }
}
