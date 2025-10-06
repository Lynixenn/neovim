return {

    -- Lensline.nvim: Codelens/Hints
    {
        'oribarilan/lensline.nvim',
        branch = 'release/2.x',
        event = 'LspAttach',
        config = function()
            require("lensline").setup({
                profiles = {
                    {
                        name = 'minimal',
                        style = {
                            placement = 'above',
                            prefix = '',
                        },
                    },
                    {
                        name = "basic",
                        providers = {
                            { name = "usages",      enabled = true, include = { "refs" }, breakdown = false },
                            { name = "last_author", enabled = true }
                        },
                        style = { render = "all", placement = "above" }
                    },
                    {
                        name = "informative",
                        providers = {
                            { name = "usages",      enabled = true, include = { "refs", "defs", "impls" }, breakdown = true },
                            { name = "diagnostics", enabled = true, min_level = "HINT" },
                            { name = "complexity",  enabled = true }
                        },
                        style = { render = "focused", placement = "inline" }
                    }
                }
            })
        end,
    },

    -- Dropbar.nvim: Breadcrumbs (Context aware). VSCode Like
    {
        'Bekaboo/dropbar.nvim',
    },
}
