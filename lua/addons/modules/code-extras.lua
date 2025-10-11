return {

    -- Lensline: Codelens plugin
    {
        'oribarilan/lensline.nvim',
        branch = 'release/2.x',
        event = 'LspAttach',
        opts = {
            profiles = {
                {
                    name = 'basic',
                    providers = {
                        { name = "usages",      enabled = true, include = { "refs", "impls" }, breakdown = false },
                        { name = "last_author", enabled = true }
                    },
                    style = {
                        placement = "above",
                        prefix = '',
                        render = "all"
                    }
                },
            }
        },
    },



    -- Dropbar: Breadcrumbs, configured to be not have the filename inside.
    {
        "Bekaboo/dropbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            bar = {
                sources = function(buf, _)
                    local sources = require('dropbar.sources')
                    local utils = require('dropbar.utils')

                    if vim.bo[buf].ft == 'markdown' then
                        return { sources.markdown }
                    end
                    if vim.bo[buf].buftype == 'terminal' then
                        return { sources.terminal }
                    end

                    return {
                        utils.source.fallback({
                            sources.lsp,
                            sources.treesitter,
                        }),
                    }
                end,
            },
        },
    }

}
