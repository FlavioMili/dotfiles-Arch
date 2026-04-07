_G.nvim_start_time = vim.uv.hrtime()

require "options"

local theme_cache_file = vim.fn.stdpath("data") .. "/selected_theme"

local function get_saved_theme()
  local f = io.open(theme_cache_file, "r")
  if f then
    local content = f:read("*all")
    f:close()
    if content then
      local theme = content:gsub("%s+", "")
      if theme ~= "" then return theme end
    end
  end
  return "bearded-arc-blueberry"
end

local function save_theme(theme_name)
  local theme = theme_name or vim.g.colors_name
  if theme and theme ~= "" and theme ~= "default" then
    local dir = vim.fn.fnamemodify(theme_cache_file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end

    local f = io.open(theme_cache_file, "w")
    if f then
      f:write(theme)
      f:close()
    end
  end
end

require "plugins"

pcall(vim.cmd, "packadd! bearded-nvim")

local ok, bearded = pcall(require, "bearded-nvim")
if ok then
  bearded.setup({})
end

-- Load saved theme early
local saved_theme = get_saved_theme()
if not pcall(vim.cmd.colorscheme, saved_theme) then
  pcall(vim.cmd.colorscheme, "bearded-arc-blueberry")
end

-- Autocmd to save theme on change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function(args)
    local theme = args.match
    if theme == "bearded" then end
    vim.schedule(function()
      save_theme(theme)
    end)
  end
})

require "configs.ui"
require "mappings"

pcall(vim.cmd, "packadd nvim.undotree")

local bg = "#111422"
vim.api.nvim_set_hl(0, "DiffAdd",    { fg = "#3CEC85", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#8eb0e6", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#E35535", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiffText",   { fg = bg, bg = "#8eb0e6" })
