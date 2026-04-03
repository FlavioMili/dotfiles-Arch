require("mini.animate").setup()
require("mini.comment").setup({})
require("mini.trailspace").setup({})

-- Elegant & Minimal Statusline
local statusline = require("mini.statusline")
statusline.setup({
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git           = statusline.section_git({ trunc_width = 75 })
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
      local location      = statusline.section_location({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl,                  strings = { " " .. mode .. " " } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git } },
        '%<', 
        { hl = 'MiniStatuslineFilename', strings = { " " .. filename .. " " } },
        '%=', 
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { " " .. location .. " " } },
      })
    end,
  },
})

-- Smart Tabline (only shows if 2+ buffers)
require("mini.tabline").setup({
  show_icons = true,
  set_vim_settings = true,
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and " ●" or ""
    return " " .. label .. suffix .. " "
  end,
})

-- DYNAMIC THEME SYNC (Improved visibility)
local function sync_mini_highlights()
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",  { link = "StatusLineNC" })
  vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { link = "StatusLineNC" })
  
  vim.api.nvim_set_hl(0, "MiniTablineCurrent", { link = "TabLineSel" })
  vim.api.nvim_set_hl(0, "MiniTablineVisible", { link = "TabLine" })
  vim.api.nvim_set_hl(0, "MiniTablineHidden",  { link = "TabLineFill" })
  vim.api.nvim_set_hl(0, "MiniTablineFill",    { link = "TabLineFill" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_mini_highlights })
sync_mini_highlights()

require("mini.pairs").setup({})
require("mini.surround").setup({})
