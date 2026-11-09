-- Sticky header: keeps the enclosing function/class/loop line pinned at the
-- top of the window once its start scrolls off-screen.
require("treesitter-context").setup({
  max_lines = 3, -- cap the header height for deeply nested code
  multiline_threshold = 1, -- show multi-line signatures as a single line
  trim_scope = "outer", -- when over max_lines, drop the outermost scopes first
})

-- Jump up to the start of the current context (function header).
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Jump to context (function header)", silent = true })
