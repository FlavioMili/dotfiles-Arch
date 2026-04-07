local M = {}

-- Global statusline
vim.o.laststatus = 3
vim.o.showtabline = 2

-- Helper to get highlight colors
local function get_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  return hl
end

-- Define theme-dependent highlight groups
local function setup_highlights()
  local sl = get_hl("StatusLine")
  local normal = get_hl("Normal")
  local sl_bg = sl.bg and string.format("#%06x", sl.bg) or (normal.bg and string.format("#%06x", normal.bg) or "#111422")
  local sl_fg = sl.fg and string.format("#%06x", sl.fg) or (normal.fg and string.format("#%06x", normal.fg) or "#8eb0e6")

  -- Use Type or Keyword for the accent color to be theme-consistent
  local type_hl = get_hl("Type")
  local accent = type_hl.fg and string.format("#%06x", type_hl.fg) or "#8eb0e6"

  vim.api.nvim_set_hl(0, "User1", { fg = sl_bg, bg = accent, bold = true }) -- Mode (Inverted)
  vim.api.nvim_set_hl(0, "User2", { fg = accent, bg = sl_bg, bold = true }) -- Info
  vim.api.nvim_set_hl(0, "User3", { fg = sl_fg, bg = sl_bg }) -- Filename
  vim.api.nvim_set_hl(0, "User4", { fg = accent, bg = sl_bg }) -- Separators
  
  -- Clear TabLine border/attributes
  vim.api.nvim_set_hl(0, "TabLine", { bg = sl_bg, fg = sl_fg, underline = false, bold = false, reverse = false })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = sl_bg, fg = sl_bg, underline = false, bold = false, reverse = false })
  vim.api.nvim_set_hl(0, "TabLineSel", { bg = accent, fg = sl_bg, bold = true })
end

-- Completion popup (matches Telescope style)
local function setup_completion_highlights()
  local normal = get_hl("Normal")
  local type_hl = get_hl("Type")
  local comment_hl = get_hl("Comment")

  local bg     = normal.bg     and string.format("#%06x", normal.bg)     or "#111422"
  local fg     = normal.fg     and string.format("#%06x", normal.fg)     or "#c8d3f5"
  local accent = type_hl.fg   and string.format("#%06x", type_hl.fg)   or "#8eb0e6"
  local muted  = comment_hl.fg and string.format("#%06x", comment_hl.fg) or "#4a5580"

  -- Main popup — same bg as your editor, like Telescope
  vim.api.nvim_set_hl(0, "Pmenu",       { bg = bg,     fg = fg })
  vim.api.nvim_set_hl(0, "PmenuSel",   { bg = accent, fg = bg, bold = true })
  vim.api.nvim_set_hl(0, "PmenuBorder", { fg = accent, bg = bg })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = accent })

  -- Floating windows (info, signature, hover) — same treatment
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg, fg = fg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = accent, bg = bg })

  -- Kind icons in the popup (the little symbols on the right)
  vim.api.nvim_set_hl(0, "CmpItemKindText",     { fg = fg })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = accent })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword",  { fg = accent })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",    { fg = accent, bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = accent })
end

setup_highlights()
setup_completion_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = setup_highlights
})

-- Statusline Implementation
local function get_mode()
  local modes = {
    ['n']  = 'NORMAL',
    ['i']  = 'INSERT',
    ['v']  = 'VISUAL',
    ['V']  = 'V-LINE',
    ['\22'] = 'V-BLOCK',
    ['c']  = 'COMMAND',
    ['R']  = 'REPLACE',
    ['t']  = 'TERMINAL',
  }
  return modes[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
end

local function get_git_branch()
  local branch = vim.b.gitsigns_head or ""
  if branch ~= "" then return "  " .. branch end
  return ""
end

local function get_file_icon(name, ext)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local icon, color = devicons.get_icon(name, ext, { default = true })
    return icon
  end
  return ""
end

function _G.statusline()
  local name = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  local icon = get_file_icon(name, ext)
  
  local parts = {
    "%#User4#%#User1# ",
    get_mode(),
    " %#User4# ",
    "%#User2#",
    get_git_branch(),
    " %#User3# ",
    icon,
    " %f %m",
    "%=",
    "%#User3# %y ",
    "%#User4#%#User1# ",
    "%l:%c ",
    "%#User4#"
  }
  return table.concat(parts)
end

vim.o.statusline = "%!v:lua.statusline()"

-- Tabline Implementation (No circular borders, simple space separators)
function _G.tabline()
  local s = ""
  for i, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
      local name = vim.api.nvim_buf_get_name(buf)
      local filename = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
      local ext = vim.fn.fnamemodify(name, ":e")
      local icon = get_file_icon(filename, ext)
      local is_active = buf == vim.api.nvim_get_current_buf()
      local hl = is_active and "%#TabLineSel#" or "%#TabLine#"
      local mod = vim.api.nvim_get_option_value("modified", { buf = buf }) and " ●" or ""
      s = s .. hl .. "  " .. icon .. " " .. filename .. mod .. "  "
    end
  end
  return s .. "%#TabLineFill#%="
end

vim.o.tabline = "%!v:lua.tabline()"

return M
