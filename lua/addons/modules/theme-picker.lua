return {
    {
        'lmantw/themify.nvim',
        lazy = false,
        priority = 999,
  
        config = function()
            require('themify').setup({
                'bettervim/yugen.nvim',
                'Mofiqul/vscode.nvim',
                'sainnhe/sonokai',
                'EdenEast/nightfox.nvim',
                'dasupradyumna/midnight.nvim',
                'bluz71/vim-moonfly-colors'
            })
            local wk = require("which-key")
            wk.add({
                { "<leader>ut", "<cmd>Themify<cr>", desc = "Theme Picker" }
            })
        end,
    }

}
