return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "atlantis"
            vim.g.sonokai_enable_italic = 0
            vim.g.sonokai_better_performance = 1
            vim.cmd.colorscheme("sonokai")
        end,
    },
}
