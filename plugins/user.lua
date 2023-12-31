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
          "                /\\_/\\                ",
          "                ( o.o )                ",
          "                 > ^ <                 ",
          "            https://zeffo.me           "

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
    enabled = true 
  },
  -- {
  -- "nvim-lualine/lualine.nvim",
  -- event = "BufEnter",
  -- config = function()
  --
  --   local catpcn = require"lualine.themes.catppuccin"
  --   catpcn.normal.a.bg = '#cba6f7'
  --   catpcn.normal.b.fg = '#b4befe'
  --   catpcn.insert.a.bg = '#f5c2e7'
  --   catpcn.insert.b.fg = '#cba6f7'
  --   catpcn.visual.a.bg = '#a6e3a1'
  --   catpcn.visual.b.fg = '#94e2d5'
  --   require("lualine").setup {
	 --    options = {
		--     icons_enabled = true,
		--     theme = catpcn,
  --       section_separators = { left = '', right = '' },
  --       component_separators = { left = '', right = '' },
		--     disabled_filetypes = { 
		--       tabline = {'neo-tree', 'NvimTree' }
		--     },
		--     extensions = { 'neo-tree', 'lazy', 'mason' },
		--     always_divide_middle = true,
		--     globalstatus = true,
	 --    },
	 --    sections = {
		--     lualine_a = { "mode" },
		--     lualine_b = { "branch", "diff", "diagnostics" },
		--     lualine_c = { "filename" },
		--     lualine_x = { "filetype" },
		--     lualine_y = { "progress" },
		--     lualine_z = { "location" },
	 --    },
	 --    inactive_sections = {
		--     lualine_a = {},
		--     lualine_b = {},
		--     lualine_c = {},
		--     lualine_x = {},
		--     lualine_y = {},
		--     lualine_z = {},
	 --    },
  --     tabline = {
  --       lualine_a = {'buffers'},
  --       lualine_b = {'branch'},
  --       lualine_c = {'filename'},
  --       lualine_x = {},
  --       lualine_y = {},
  --       lualine_z = {'tabs'},
  --     },
  --   }
  -- end
  -- }
}
