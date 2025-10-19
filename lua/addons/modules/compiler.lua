return {
    display = "Compiler (Build & Run)",
    plugins = {
        {
            "Zeioth/compiler.nvim",
            cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
            dependencies = { "stevearc/overseer.nvim" },
            opts = {},
            keys = {
                { "<f6>", "<cmd>compileropen<cr>", desc = "open compiler" },
                { "<s-f6>", "<cmd>compilerredo<cr>", desc = "redo last compiler task" },
                { "<s-f7>", "<cmd>compilertoggleresults<cr>", desc = "toggle compiler results" },
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
}