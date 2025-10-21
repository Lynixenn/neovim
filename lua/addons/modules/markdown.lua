return {
    display = "Markview",
    plugins = {
        {
            'OXY2DEV/markview.nvim',
            dependencies = {
                'nvim-treesitter/nvim-treesitter',
            },
            ft = { "markdown", "rmd", "qmd" },
            opts = {
                markdown = { -- Tables config goes inside markdown
                    tables = {
                        enable = true,
                        strict = true,
                    },
                },
                latex = {
                    enable = true,
                    inlines = true,
                    blocks = {
                        enable = true,
                    },
                },
            },
        }
    }
}