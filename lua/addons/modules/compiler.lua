-- Compiler: Build and run code without configuration
return {
    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        opts = {},
        keys = {
            { "<F6>", "<cmd>CompilerOpen<cr>", desc = "Open Compiler" },
            { "<S-F6>", "<cmd>CompilerRedo<cr>", desc = "Redo Last Compiler Task" },
            { "<S-F7>", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results" },
        },
    },
    {
        "stevearc/overseer.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
            },
        },
    },
}

