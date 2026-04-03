local function get_info_text()
  local now = vim.uv.hrtime()
  local start_time = _G.nvim_start_time or now
  local diff = (now - start_time) / 1e6
  local count = _G.plugin_count or 0
  -- Matching your requested style: "neovim loaded X plugins in Yms"
  return string.format("neovim loaded %d plugins in %.2fms", count, diff)
end

require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = {
      get_info_text(),
      '',
      ' █████▒██▓    ▄▄▄    ██▒   █▓ ██▓ ███▄ ▄███▓',
      '▓██   ▒▓██▒   ▒████▄ ▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
      '▒████ ░▒██░   ▒██  ▀█▄▓██  █▒░▒██▒▓██    ▓██░',
      '░▓█▒  ░▒██░   ░██▄▄▄▄██▒██ █░░░██░▒██    ▒██ ',
      '░▒█░   ░██████▒▓█   ▓██▒▒▀█░  ░██░▒██▒   ░██▒',
      ' ▒ ░   ░ ▒░▓  ░▒▒   ▓▒█░░ ▐░  ░▓  ░ ▒░   ░  ░',
      ' ░     ░ ░ ▒  ░ ▒   ▒▒ ░░ ░░   ▒ ░░  ░      ░',
      ' ░ ░     ░ ░    ░   ▒     ░░   ▒ ░░      ░   ',
      '           ░  ░     ░  ░   ░   ░         ░   ',
      '                          ░                   ',
      '',
    },
    shortcut ={
      { desc = "󰈞  Find File", group = "Label", action = "Telescope find_files", key = "f" },
      { desc = "󰊄  Recent Files", group = "Label", action = "Telescope oldfiles", key = "o" },
      { desc = "󰈭  Find Word", group = "Label", action = "Telescope live_grep", key = "w" },
    },
    footer = { "", "Let’s pretend this never happened!" },
  },
}
