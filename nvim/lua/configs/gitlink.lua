local function gitlink()
  if not package.loaded["gitlink"] then
    require("gitlink").setup({})
  end
  return require("gitlink")
end

vim.keymap.set({ "n", "v" }, "<leader>gl", function()
  local gl = gitlink()

  local mode = vim.fn.mode()
  local l1, l2

  if mode:match("[vV\22]") then
    local vstart = vim.fn.getpos("v")[2]
    local cursor = vim.api.nvim_win_get_cursor(0)[1]

    l1, l2 = vstart, cursor
    if l1 > l2 then l1, l2 = l2, l1 end
  end

  if l1 then
    gl.get_link({ line1 = l1, line2 = l2 })
  else
    gl.get_link()
  end
end, { desc = "Copy git link", silent = true })
