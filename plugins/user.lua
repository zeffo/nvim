return {
  {
    "catppuccin/nvim",
    event = "BufRead",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          aerial = true,
          alpha = true,
          mason = true,
          treesitter = true,
          notify = true,
          neotree = true,
          indent_blankline = {
              enabled = true,
              colored_indent_levels = true,
          },

        },
        highlight_overrides = {
          all = function(colors)
            return {
              -- Add highlight group overrides here
            }
            end
        }
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
