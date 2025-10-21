return {
    display = "Search and Replace UI Plugin",
    plugins = {
        {
            "MagicDuck/grug-far.nvim",
            cmd = "GrugFar",
            keys = {
                {
                    "<leader>s",
                    group = "Replace"
                },
                {
                    "<leader>sr",
                    function()
                        require("grug-far").open()
                    end,
                    desc = "Search and Replace",
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
                })
            end,
        }
    }
}