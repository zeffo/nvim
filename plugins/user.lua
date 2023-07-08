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

        },
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
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) 
      opts.section.header.val = { 
          "  █████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ",
          " ██╔══██╗████╗ ████║██╔══██╗████╗  ██║ ",
          " ███████║██╔████╔██║███████║██╔██╗ ██║ ",
          " ██╔══██║██║╚██╔╝██║██╔══██║██║╚██╗██║ ",
          " ██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║ ",
          " ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ",
      }
    end,
  },
}
