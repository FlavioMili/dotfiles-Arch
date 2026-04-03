local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<F10>", ":make <cr>", { desc = "cmake build" })

map("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- Telescope (Fuzzy Finder)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer" })
map("n", "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Find colorschemes" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

-- LSP "doing stuff"
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP rename" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Diagnostic show buffer" })

-- Gitlink
map({ "n", "v" }, "<leader>gl", function()
  local gl = require("gitlink")
  local mode = vim.fn.mode()
  local l1, l2

  if mode:match("[vV\22]") then
    local vstart = vim.fn.getpos("v")[2]
    local cursor = vim.api.nvim_win_get_cursor(0)[1]

    l1, l2 = vstart, cursor
    if l1 > l2 then l1, l2 = l2, l1 end
  end

  if l1 then gl.get_link({ line1 = l1, line2 = l2 })
  else gl.get_link() end
end, { desc = "Copy git link" })

-- Hop
map({ "n", "x", "o" }, "<leader>fj", function()
  require("hop").hint_words()
end, { desc = "Hop hint words" })

-- Undotree (Built-in)
map("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Undo history" })

-- Neo-tree
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
map("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })

-- Git Diffs (Gitsigns)
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git Diff (whole file)" })
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Git Hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame" })


-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Terminal
map("n", "<leader>tt", "<cmd>split | terminal<cr>i", { desc = "Open terminal horizontal" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })

-- Copy whole file to clipboard
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "Copy whole file to clipboard" })

-- Commenting (using built-in or mini.comment)
map("n", "<leader>/", function()
  require("mini.comment").toggle_lines(vim.fn.line("."), vim.fn.line("."))
end, { desc = "Toggle comment" })
map("v", "<leader>/", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  require("mini.comment").toggle_lines(vim.fn.line("'<"), vim.fn.line("'>"))
end, { desc = "Toggle comment" })
