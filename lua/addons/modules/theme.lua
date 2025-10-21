return {
    display = "Sonokai Atlantis",
    plugins = {
        {
            "sainnhe/sonokai",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.sonokai_style = "atlantis"
                vim.g.sonokai_enable_italic = 0
                vim.g.sonokai_better_performance = 1
                vim.cmd.colorscheme("sonokai")

                local cursorline_bg = vim.api.nvim_get_hl(0, { name = 'CursorLine' }).bg
                vim.api.nvim_set_hl(0, 'CursorLineNr', {
                    bg = cursorline_bg
                })
            end,
        },
    }
}