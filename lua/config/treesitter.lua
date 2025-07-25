require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "cpp", "lua", "vim", "json", "c" },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}
