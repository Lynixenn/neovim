return {
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    require("grug-far").open()
                end,
                desc = "Search and Replace",
            },
            {
                "<leader>sw",
                function()
                    require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
                end,
                desc = "Search word under cursor",
            },
            {
                "<leader>sf",
                function()
                    require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
                end,
                desc = "Search in current file",
            },
            {
                "<leader>sr",
                function()
                    require("grug-far").with_visual_selection()
                end,
                mode = "v",
                desc = "Search visual selection",
            },
        },
        config = function()
            vim.g.maplocalleader = " "
            require("grug-far").setup({
                -- Options, see https://github.com/MagicDuck/grug-far.nvim
            })
        end,
    }
}
