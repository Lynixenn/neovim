return {
    {
        "nvim-java/nvim-java",
        ft = { "java" },
        config = function()
            require('java').setup()
        end,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    local wk = require("which-key")
                    wk.add({
                        { "<leader>y",  group = "Java",                      buffer = 0 },
                        { "<leader>yr", "<cmd>JavaRunnerRunMain<CR>",        desc = "Run Main",    buffer = 0 },
                        { "<leader>yt", "<cmd>JavaTestRunCurrentClass<CR>",  desc = "Test Class",  buffer = 0 },
                        { "<leader>ym", "<cmd>JavaTestRunCurrentMethod<CR>", desc = "Test Method", buffer = 0 },
                    })
                end,
            })
        end,
    },
}
