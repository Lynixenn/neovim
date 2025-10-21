-- Leader Key
vim.g.mapleader = " "

-- UI
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%s%l  "
vim.opt.title = true
vim.opt.fillchars = {
    vert = " ",
    vertleft = " ",
    vertright = " ",
    verthoriz = " ",
}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.inccommand = "split"

-- Tabs / Indenting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.gdefault = true

-- Window
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.winborder = "none"

-- General
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 150
vim.opt.autowriteall = true
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Flash on copy/yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Auto-reload on focus/buffer switch
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
})
