return {
    display = "Java Extras (Extended Java Support + Debug)",
    plugins = {
        {
            "nvim-java/nvim-java",
            ft = { "java" },
            config = function()
                require('java').setup()
            end,
            init = function()
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "java",
                })
            end,
        },
    }
}