return {
    display = "Helpers for Pairing + Surround",
    plugins = {
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            opts = {
                check_ts = true,
                fast_wrap = {},
            },
        },

        {
            "kylechui/nvim-surround",
            version = "*",
            keys = {
                { "ys",  mode = "n", desc = "Add surround" },
                { "yss", mode = "n", desc = "Add surround line" },
                { "yS",  mode = "n", desc = "Add surround (linewise)" },
                { "ySS", mode = "n", desc = "Add surround line (linewise)" },
                { "ds",  mode = "n", desc = "Delete surround" },
                { "cs",  mode = "n", desc = "Change surround" },
                { "S",   mode = "v", desc = "Surround visual selection" },
                { "gS",  mode = "v", desc = "Surround visual selection (linewise)" },
            },
            config = true,
        }
    }
}