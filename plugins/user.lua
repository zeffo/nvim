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
          -- neotree = true,
        },
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.background_colour = "#000000"
    end
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- opts.section.header.opts.hl = "SpecialChar"
      for k, v in pairs(opts.section.buttons.val) do
        v.opts.hl = "Keyword"
        v.opts.hl_shortcut = "Error"
      end
      gradient = {
        "SpecialChar", 
        "Keyword", 
        "Error", 
        "@parameter", 
        "Constant", 
        "Structure", 
        "String", 
        "Character",
        "Operator",
        "@constructor",
        "Function",
        "@field"
      }
      local text = {
          "  █████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ",
          " ██╔══██╗████╗ ████║██╔══██╗████╗  ██║ ",
          " ███████║██╔████╔██║███████║██╔██╗ ██║ ",
          " ██╔══██║██║╚██╔╝██║██╔══██║██║╚██╗██║ ",
          " ██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║ ",
          " ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ",
          "                                       ",
          "                                      ",
          "                /\\_/\\                ",
          "                ( o.o )                ",
          "                 > ^ <                 ",
          "            https://zeffo.me           ",

      }
      local lines = {}
      for i, l in ipairs(text) do
        local line = {
          type = "text",
          val=l,
          opts = { hl = gradient[i], position="center" }
        }
        lines[i] = line
      end
      local header = {
        type = "group",
        val = lines,
        opts = {position="center"}
      }
      opts.config.layout[2] = header
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    config = function ()
      require("jdtls")
    end
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astronvim.utils.status")
      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg"},
        status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        -- remove the 2nd mode indicator on the right
      }

      -- return the final configuration table
      return opts
    end,
  },
  {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts) require'lsp_signature'.setup(opts) end
  }
}
