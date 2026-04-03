require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', -- center align
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
  },
})
