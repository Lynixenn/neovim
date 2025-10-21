return {
    display = "Rust Extras (Rustacean & extended Cargo Support)",
    plugins = {
        {
            "mrcjkb/rustaceanvim",
            version = "^5",
            ft = { "rust" },
            event = { "BufRead Cargo.toml" },
            init = function()
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "rust",
                    callback = function()
                        local wk = require("which-key")
                        wk.add({
                            { "<leader>y",  group = "Rust",                 buffer = 0 },
                            { "<leader>yr", "<cmd>RustLsp runnables<CR>",   desc = "Run",          buffer = 0 },
                            { "<leader>yt", "<cmd>RustLsp testables<CR>",   desc = "Test",         buffer = 0 },
                            { "<leader>ye", "<cmd>RustLsp expandMacro<CR>", desc = "Expand Macro", buffer = 0 },
                        })
                    end,
                })
            end,
        },

        {
            "Saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
            init = function()
                vim.api.nvim_create_autocmd("BufRead", {
                    pattern = "Cargo.toml",
                    callback = function()
                        local wk = require("which-key")
                        local crates = require("crates")
                        wk.add({
                            { "<leader>y",  group = "Crates",           buffer = 0 },
                            { "<leader>yv", crates.show_versions_popup, desc = "Show Versions", buffer = 0 },
                            { "<leader>yu", crates.update_crate,        desc = "Update Crate",  buffer = 0 },
                        })
                    end,
                })
            end,
            config = function()
                require("crates").setup()
            end,
        },
    }
}