require("blink.cmp").setup({
  enabled = function()
    return not (vim.api.nvim_get_mode().mode == 'c')
  end,
  keymap = { 
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    ghost_text = { enabled = true },
    menu = { 
      border = 'rounded',
      draw = { 
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } 
      } 
    },
    documentation = { 
      auto_show = true, 
      auto_show_delay_ms = 200,
      window = { border = 'rounded' } 
    },
  },
  cmdline = { enabled = false },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  signature = { enabled = true, window = { border = 'rounded' } }
})
