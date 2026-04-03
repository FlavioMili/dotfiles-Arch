_G.nvim_start_time = vim.uv.hrtime()

require "options"
require "plugins"
require "mappings"

-- Theme Persistence Logic
local theme_cache_file = vim.fn.stdpath("data") .. "/selected_theme"

local function save_theme()
  local theme = vim.g.colors_name
  if theme then
    local f = io.open(theme_cache_file, "w")
    if f then
      f:write(theme)
      f:close()
    end
  end
end

local function get_saved_theme()
  local f = io.open(theme_cache_file, "r")
  if f then
    local theme = f:read("*all")
    f:close()
    return theme:gsub("%s+", "") -- trim whitespace
  end
  return "bearded-arc-blueberry" -- Default
end

-- Ensure theme is set AFTER plugins have been added to runtimepath
vim.schedule(function()
  -- Add built-in undotree
  pcall(vim.cmd, "packadd nvim.undotree")

  local saved_theme = get_saved_theme()
  
  -- Try to setup and set colorscheme
  local ok, theme = pcall(require, "bearded-nvim")
  if ok then
    theme.setup({})
    vim.cmd.colorscheme(saved_theme)
  else
    pcall(vim.cmd.colorscheme, saved_theme)
  end

  -- FIX GIT DIFF COLORS (Green on green / visibility)
  -- We do this after colorscheme is loaded to override its defaults
  local bg = "#111422" -- theme background
  vim.api.nvim_set_hl(0, "DiffAdd",    { fg = "#3CEC85", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = "#8eb0e6", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#E35535", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiffText",   { fg = bg, bg = "#8eb0e6" }) -- The actual changed text block
end)

-- Auto-save theme whenever it changes (e.g. via Telescope)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = save_theme
})
