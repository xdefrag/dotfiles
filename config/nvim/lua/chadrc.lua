-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_dark",

  tabufline = {
    enabled = false,
  },
}

M.base46 = {
  integrations = {
    "blankline",
    "cmp",
    "git",
  },
}

return M
