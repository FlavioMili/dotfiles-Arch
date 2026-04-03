local options = {
   formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier" },
      html = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "black", "isort" },
      go = { "gopls", "goimports", "gofmt" },
      rust = {"rustfmt", lsp_format = "fallback"},
   },

   format_on_save = {
     timeout_ms = 500,
     lsp_fallback = true,
   },
}

require("conform").setup(options)
