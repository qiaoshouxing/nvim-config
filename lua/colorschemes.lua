--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme_conf = {
  solarized_dark = function()
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end,

  solarized_light = function()
    vim.o.termguicolors = true
    vim.o.background = 'light'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  --local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme_conf))
  local colorscheme = "solarized_dark"

  if not vim.tbl_contains(vim.tbl_keys(M.colorscheme_conf), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme and its settings
  M.colorscheme_conf[colorscheme]()
end

return M
