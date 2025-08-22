local utils = require("utils")

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- check if firenvim is active
local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

local plugin_specs = {
-- auto-completion engine
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-omni", lazy = true },
  { "hrsh7th/cmp-cmdline", lazy = true },
  { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    name = "nvim-cmp",
    event = "VeryLazy",
    config = function()
      require("config.nvim-cmp")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end,
  },
--  {
--    "dnlhc/glance.nvim",
--    config = function()
--      require("config.glance")
--    end,
--    event = "VeryLazy",
--  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
--
---- Python indent (follows the PEP8 style)
--{ "Vimjas/vim-python-pep8-indent", ft = { "python" } },
--
---- Python-related text object
--{ "jeetsukumaran/vim-pythonsense", ft = { "python" } },
--
--{ "machakann/vim-swap", event = "VeryLazy" },
--
--  -- Super fast buffer jump
--  {
--    "smoka7/hop.nvim",
--    event = "VeryLazy",
--    config = function()
--      require("config.nvim_hop")
--    end,
--  },
--
--  "nvim-lua/plenary.nvim",
--  {
--    "nvim-telescope/telescope.nvim",
--    cmd = "Telescope",
--    dependencies = {
--      "nvim-telescope/telescope-symbols.nvim",
--    },
--  },
--  {
--    "ibhagwan/fzf-lua",
--    -- optional for icon support
--    dependencies = { "nvim-tree/nvim-web-devicons" },
--    config = function()
--      require("config.fzf-lua")
--    end,
--  },
--  {
--    "MeanderingProgrammer/markdown.nvim",
--    main = "render-markdown",
--    opts = {},
--    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
--  },

  -- A list of colorscheme plugin you may want to try. Find what suits you.
  { 'maxmx03/solarized.nvim', lazy = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    cond = firenvim_not_active,
    config = function()
      require("config.lualine")
    end,
  },

--  {
--    "akinsho/bufferline.nvim",
--    event = { "BufEnter" },
--    cond = firenvim_not_active,
--    config = function()
--      require("config.bufferline")
--    end,
--  },
--
--  -- fancy start screen
--  {
--    "nvimdev/dashboard-nvim",
--    cond = firenvim_not_active,
--    config = function()
--      require("config.dashboard-nvim")
--    end,
--  },
--
--  {
--    "lukas-reineke/indent-blankline.nvim",
--    event = "VeryLazy",
--    main = "ibl",
--    config = function()
--      require("config.indent-blankline")
--    end,
--  },
--  {
--    "luukvbaal/statuscol.nvim",
--    opts = {},
--    config = function()
--      require("config.nvim-statuscol")
--    end,
--  },
--  {
--    "kevinhwang91/nvim-ufo",
--    dependencies = "kevinhwang91/promise-async",
--    event = "VeryLazy",
--    opts = {},
--    init = function()
--      vim.o.foldcolumn = "1" -- '0' is not bad
--      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--      vim.o.foldlevelstart = 99
--      vim.o.foldenable = true
--    end,
--    config = function()
--      require("config.nvim_ufo")
--    end,
--  },
--  -- Highlight URLs inside vim
--  { "itchyny/vim-highlighturl", event = "VeryLazy" },
--
  -- notification plugin
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("config.nvim-notify")
    end,
  },
--
--  -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
--  -- not be possible since we maybe in a server which disables GUI.
--  {
--    "chrishrb/gx.nvim",
--    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
--    cmd = { "Browse" },
--    init = function()
--      vim.g.netrw_nogx = 1 -- disable netrw gx
--    end,
--    enabled = function()
--      return vim.g.is_win or vim.g.is_mac
--    end,
--    dependencies = { "nvim-lua/plenary.nvim" },
--    config = true, -- default settings
--    submodules = false, -- not needed, submodules are required only for tests
--  },
--
--  -- Only install these plugins if ctags are installed on the system
--  -- show file tags in vim window
--  {
--    "liuchengxu/vista.vim",
--    enabled = function()
--      return utils.executable("ctags")
--    end,
--    cmd = "Vista",
--  },
--
  -- Snippet engine and snippet template
  {
    "SirVer/ultisnips",
    dependencies = {
      "honza/vim-snippets",
    },
    event = "InsertEnter",
  },
--
--  -- Comment plugin
--  { "tpope/vim-commentary", event = "VeryLazy" },
--
--  -- Multiple cursor plugin like Sublime Text?
--  -- 'mg979/vim-visual-multi'
--
--  -- Show undo history visually
--  { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } },
--
--  -- Manage your yank history
--  {
--    "gbprod/yanky.nvim",
--    config = function()
--      require("config.yanky")
--    end,
--    event = "VeryLazy",
--  },
--
--  -- Handy unix command inside Vim (Rename, Move etc.)
--  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },
--
--  -- Git command inside vim
--  {
--    "tpope/vim-fugitive",
--    event = "User InGitRepo",
--    config = function()
--      require("config.fugitive")
--    end,
--  },
--
--  -- Better git log display
--  { "rbong/vim-flog", cmd = { "Flog" } },
--  { "akinsho/git-conflict.nvim", version = "*", config = true },
--  {
--    "ruifm/gitlinker.nvim",
--    event = "User InGitRepo",
--    config = function()
--      require("config.git-linker")
--    end,
--  },
--
--  -- Show git change (change, delete, add) signs in vim sign column
--  {
--    "lewis6991/gitsigns.nvim",
--    config = function()
--      require("config.gitsigns")
--    end,
--  },
--
--  {
--    "sindrets/diffview.nvim",
--  },
--
---- The missing auto-completion for cmdline!
--  {
--    "gelguy/wilder.nvim",
--    build = ":UpdateRemotePlugins",
--  },
--
--  -- showing keybindings
--  {
--    "folke/which-key.nvim",
--    event = "VeryLazy",
--    config = function()
--      require("config.which-key")
--    end,
--  },
--  {
--    "folke/snacks.nvim",
--    priority = 1000,
--    lazy = false,
--    opts = {
--      -- more beautiful vim.ui.input
--      input = {
--        enabled = true,
--        win = {
--          relative = "cursor",
--          backdrop = true,
--        },
--      },
--      -- more beautiful vim.ui.select
--      picker = { enabled = true },
--    },
--  },
--  -- show and trim trailing whitespaces
--  { "jdhao/whitespace.nvim", event = "VeryLazy" },
--
  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end,
  },
    -- plugins to provide nerdfont icons
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      -- this is the compatibility fix for plugins that only support nvim-web-devicons
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.icons").tweak_lsp_kind()
    end,
    lazy = true,
  },

}

---@diagnostic disable-next-line: missing-fields
require("lazy").setup {
  spec = plugin_specs,
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
}
