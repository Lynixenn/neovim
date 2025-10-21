vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'D', '"_D', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { noremap = true })

local wk = require("which-key")
wk.add({
    -- Basic editor commands
    { "<Esc>",      "<cmd>nohlsearch<cr>",                              desc = "Clear search highlight",     mode = "n" },

    -- Moving lines up and down
    { "<A-j>",      ":m .+1<CR>==",                                     desc = "Move line up",               mode = "n" },
    { "<A-k>",      ":m .-2<CR>==",                                     desc = "Move line down",             mode = "n" },
    { "<A-j>",      ":m '<-2<CR>gv=gv",                                 desc = "Move selection down",        mode = "v" },
    { "<A-k>",      ":m '>+1<CR>gv=gv",                                 desc = "Move selection up",          mode = "v" },

    -- Indenting Lines
    { "<",          "<gv",                                              desc = "Indent left and re-select",  mode = "v" },
    { ">",          ">gv",                                              desc = "Indent right and re-select", mode = "v" },

    -- Window navigation
    { "<C-h>",      "<C-w>h",                                           desc = "Move to left window",        mode = "n" },
    { "<C-j>",      "<C-w>j",                                           desc = "Move to bottom window",      mode = "n" },
    { "<C-k>",      "<C-w>k",                                           desc = "Move to top window",         mode = "n" },
    { "<C-l>",      "<C-w>l",                                           desc = "Move to right window",       mode = "n" },

    -- Split windows
    { "<leader>wv", "<cmd>vsplit<cr>",                                  desc = "Split vertically",           mode = "n" },
    { "<leader>wh", "<cmd>split<cr>",                                   desc = "Split horizontally",         mode = "n" },
    { "<leader>wc", "<cmd>close<cr>",                                   desc = "Close window",               mode = "n" },
    { "<leader>wo", "<cmd>only<cr>",                                    desc = "Close other windows",        mode = "n" },

    -- File explorer Group
    { "<leader>e",  group = "Filetree" },
    { "<leader>ee", "<cmd>Neotree toggle<CR>",                          desc = "Toggle Filetree",            mode = "n" },
    { "<leader>ef", "<cmd>Neotree focus<CR>",                           desc = "Focus Filetree",             mode = "n" },

    -- Find group (Telescope)
    { "<leader>f",  group = "Find" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find files",                 mode = 'n' },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                     desc = "Live grep",                  mode = 'n' },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Find buffers",               mode = 'n' },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",                     desc = "Help tags",                  mode = 'n' },

    -- Buffer group
    { "<leader>b",  group = "Buffer" },
    { "<leader>bd", function() require("mini.bufremove").delete() end,  desc = "Delete buffer",              mode = "n" },

    -- Terminal group
    { "<leader>t",  group = "Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Vertical Terminal",          mode = "n" },
    { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal",        mode = "n" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Floating Terminal",          mode = "n" },

    -- UI group
    { "<leader>u",  group = "UI" },

    -- Addons menu
    { "<leader>a",  function() require("addons.menu").show() end,       desc = "Toggle Addons",              mode = "n" },
})
