require("bufferline").setup({
  options = {
    mode = "buffers",
    style_preset = require("bufferline").style_preset.default,
    themable = true,
    numbers = "none",
    close_command = "bdelete %d",
    right_mouse_command = "bdelete %d",
    left_mouse_command = "buffer %d",
    indicator = {
      style = 'none',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    max_name_length = 18,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        text_align = "left",
        separator = false
      }
    },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = true,
    separator_style = "flat",
    enforce_regular_tabs = false,
    -- HIDE if single file
    always_show_bufferline = false,
    auto_toggle_bufferline = true,
    sort_by = 'id',
  },
  highlights = {
    buffer_selected = {
      fg = "#8eb0e6",
      bold = true,
      italic = true,
    },
    modified_selected = {
      fg = "#EACD61",
    },
    buffer_visible = {
      fg = "#bcc1dc",
    },
    close_button_visible = {
      fg = "#565f89",
    },
  }
})
