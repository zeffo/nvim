return {
  {
    "catppuccin/nvim",
    event = "BufRead",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    event="BufRead",
    config = function()
      require("notify").setup({
        background_color = "#000000"
      })
    end
  }
}
