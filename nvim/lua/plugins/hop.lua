return {
  {
    "smoka7/hop.nvim",
    opts = {
      multi_windows = true,
      keys = "wertiopksjdmxnc",
      uppercase_labels = false,
    },
    keys = {
      {
        "<leader>fj",
        function ()
          require("hop").hint_words()
        end,
        mode = { "n", "x", "o" }
      }
    }
  },

}
