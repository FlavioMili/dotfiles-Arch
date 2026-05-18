local options = {
   formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier" },
      html = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "black", "isort" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt", lsp_format = "fallback" },
   },

   formatters = {
      ["clang-format"] = {
         prepend_args = {
            "-style={BasedOnStyle: Google, ColumnLimit: 100, InsertNewlineAtEOF: true, AllowShortLoopsOnASingleLine: true, AllowShortIfStatementsOnASingleLine: Always, AllowShortBlocksOnASingleLine: Always}",
         },
      },
   },

   -- format_on_save = {
   --   timeout_ms = 500,
   --   lsp_fallback = true,
   -- },
}

require("conform").setup(options)
