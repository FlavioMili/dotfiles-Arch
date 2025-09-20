-- load defaults i.e lua_lsp


-- This comes from the new version of LSPs in neovim
require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls", "clangd", "ruff", "vhdl_ls", "gopls" }
vim.lsp.enable(servers)




-- EXAMPLE
-- local lspconfig = require "lspconfig"
-- local nvlsp     = require "nvchad.configs.lspconfig"


-- for _, server in ipairs(servers) do
--   lspconfig[server].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--   }
-- end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
