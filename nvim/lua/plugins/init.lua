local plugins = {
  { name = "mini.nvim", src = "https://github.com/nvim-mini/mini.nvim" },
  { name = "nvim-lspconfig", src = "https://github.com/neovim/nvim-lspconfig" },
  { name = "nvim-treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { name = "conform.nvim", src = "https://github.com/stevearc/conform.nvim" },
  { name = "dashboard-nvim", src = "https://github.com/nvimdev/dashboard-nvim" },
  { name = "gitlink.nvim", src = "https://github.com/FlavioMili/gitlink.nvim" },
  { name = "hop.nvim", src = "https://github.com/smoka7/hop.nvim" },
  { name = "neo-tree.nvim", src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { name = "nui.nvim", src = "https://github.com/MunifTanjim/nui.nvim" },
  { name = "gitsigns.nvim", src = "https://github.com/lewis6991/gitsigns.nvim" },
  { name = "lualine.nvim", src = "https://github.com/nvim-lualine/lualine.nvim" },
  { name = "bufferline.nvim", src = "https://github.com/akinsho/bufferline.nvim" },
  { name = "telescope.nvim", src = "https://github.com/nvim-telescope/telescope.nvim" },
  { name = "plenary.nvim", src = "https://github.com/nvim-lua/plenary.nvim" },
  { name = "nvim-web-devicons", src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "bearded-nvim", src = "https://github.com/Ferouk/bearded-nvim" },
  { name = "which-key.nvim", src = "https://github.com/folke/which-key.nvim" },
}

_G.plugin_count = #plugins

local configs = {
  ["mini.nvim"] = "configs.mini",
  ["nvim-lspconfig"] = "configs.lspconfig",
  ["nvim-treesitter"] = "configs.treesitter",
  ["conform.nvim"] = "configs.conform",
  ["dashboard-nvim"] = "configs.dashboard",
  ["gitlink.nvim"] = "configs.gitlink",
  ["hop.nvim"] = "configs.hop",
  ["neo-tree.nvim"] = "configs.neotree",
  ["gitsigns.nvim"] = "configs.gitsigns",
  ["lualine.nvim"] = "configs.lualine",
  ["bufferline.nvim"] = "configs.bufferline",
  ["telescope.nvim"] = "configs.telescope",
  ["which-key.nvim"] = "configs.whichkey",
}

local function load_config(name, critical)
  local config_mod = configs[name]
  if config_mod then
    local ok, err = pcall(require, config_mod)
    if not ok then
      if critical or not err:match("module '.*' not found") then
        vim.notify("Error loading " .. config_mod .. ": " .. err, vim.log.levels.ERROR)
      end
    end
  end
end

vim.pack.add(plugins)

pcall(require, "nvim-web-devicons")
load_config("which-key.nvim", true)
load_config("lualine.nvim", true)
load_config("bufferline.nvim", true)
load_config("mini.nvim", true)
load_config("gitsigns.nvim", true)

vim.schedule(function()
  for _, p in ipairs(plugins) do
    if not ({["which-key.nvim"]=1, ["lualine.nvim"]=1, ["bufferline.nvim"]=1, ["mini.nvim"]=1, ["gitsigns.nvim"]=1, })[p.name] then
      load_config(p.name, false)
    end
  end
end)
