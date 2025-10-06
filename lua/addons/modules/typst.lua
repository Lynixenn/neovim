-- Typst: Document preparation system
return {
    {
        "chomosuke/typst-preview.nvim",
        version = "1.*",
        ft = "typst",
        opts = {},
    },

    {
        "kaarmu/typst.vim",
        ft = "typst",
        init = function()
            -- Setup Typst keymaps when FileType is typst
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "typst",
                group = vim.api.nvim_create_augroup("typst_keymaps", { clear = true }),
                desc = "Setup Typst keymaps",
                callback = function()
                    local wk = require("which-key")
                    wk.add({
                        -- Group header
                        { "<leader>y", group = "Typst", icon = { icon = "", color = "orange" }, buffer = 0 },

                        -- Preview controls
                        { "<leader>yp", "<cmd>TypstPreviewToggle<CR>", desc = "Preview Toggle", icon = { icon = "󰈔", color = "green" }, mode = "n", buffer = 0, silent = true },
                        { "<leader>ys", "<cmd>TypstPreview<CR>", desc = "Preview Start", icon = { icon = "", color = "green" }, mode = "n", buffer = 0, silent = true },
                        { "<leader>yS", "<cmd>TypstPreviewStop<CR>", desc = "Preview Stop", icon = { icon = "", color = "red" }, mode = "n", buffer = 0, silent = true },
                        { "<leader>yf", "<cmd>TypstPreviewFollowCursorToggle<CR>", desc = "Preview Follow Cursor", icon = { icon = "", color = "cyan" }, mode = "n", buffer = 0, silent = true },
                        { "<leader>yy", "<cmd>TypstPreviewSyncCursor<CR>", desc = "Preview Sync Now", icon = { icon = "󰒓", color = "cyan" }, mode = "n", buffer = 0, silent = true },

                        -- Build helper
                        {
                            "<leader>yb",
                            function()
                                vim.cmd.write()
                                local file = vim.fn.expand('%')
                                if file == '' then
                                    vim.notify("Cannot compile an unnamed buffer.", vim.log.levels.ERROR)
                                    return
                                end

                                local cmd = { "typst", "compile", file }
                                local stdout_lines = {}
                                local stderr_lines = {}

                                vim.notify("Typst compilation started for " .. file, vim.log.levels.INFO)

                                vim.fn.jobstart(cmd, {
                                    on_stdout = function(_, data)
                                        if data then
                                            for _, line in ipairs(data) do
                                                if line ~= "" then table.insert(stdout_lines, line) end
                                            end
                                        end
                                    end,
                                    on_stderr = function(_, data)
                                        if data then
                                            for _, line in ipairs(data) do
                                                if line ~= "" then table.insert(stderr_lines, line) end
                                            end
                                        end
                                    end,
                                    on_exit = function(_, exit_code)
                                        if exit_code == 0 then
                                            vim.notify("Typst compiled successfully: " .. file, vim.log.levels.INFO)
                                        else
                                            local error_message = "Typst compilation failed for " ..
                                                file .. " (exit code: " .. exit_code .. ")"
                                            local output = {}
                                            for _, l in ipairs(stderr_lines) do table.insert(output, l) end
                                            for _, l in ipairs(stdout_lines) do table.insert(output, l) end

                                            if #output > 0 then
                                                error_message = error_message .. "\n" .. table.concat(output, "\n")
                                            end
                                            vim.notify(error_message, vim.log.levels.ERROR)
                                        end
                                    end,
                                })
                            end,
                            desc = "Compile file",
                            icon = { icon = "󰄳", color = "yellow" },
                            mode = "n",
                            buffer = 0,
                            silent = true
                        },
                    })
                end,
            })
        end,
    },
}

