return {
  {
    "mrcjkb/rustaceanvim",
    version = "^2", -- Recommended
    ft = { "rust" },
  },
  {
    "Saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup({
        -- any options here
      })
    end,
  },
}
