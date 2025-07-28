return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 49,
  config = function()
    require("markview").setup({
      experimental = {
        check_rtp_message = false
      }
    })
  end,
}
