return {
  {
    "catppuccin/nvim",
    event = "BufRead",
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          aerial = true,
          mason = true,
          treesitter = true,
          neotree = true,
          dadbod_ui = true,
          which_key = true,
          snacks = {
            enabled = true,
            indent_scope_color = "pink",
          },
          mini = {
            enabled = true,
            indentscope_color = "pink",
          },
          blink_cmp = true,
          telescope = true,
          illuminate = {
            enabled = true,
            lsp = false,
          },
        },
        custom_highlights = function(colors)
          return {
            IncSearch = { bg = colors.pink, fg = colors.crust },
            FloatBorder = { fg = colors.pink },
            PmenuSel = { fg = colors.crust, bg = colors.pink },
            BlinkCmpScrollBarThumb = { bg = colors.mauve, fg = colors.mauve },
            BlinkCmpKind = { fg = colors.pink },
            BlinkCmpLabelMatch = { fg = colors.pink, style = { "bold" } },
            NeoTreeRootName = { fg = colors.pink },
            NeoTreeDirectoryName = { fg = colors.mauve },
            NeoTreeDirectoryIcon = { fg = colors.mauve },
            NeoTreeIndentMarker = { fg = colors.mauve },
            Visual = { bg = colors.peach, fg = colors.crust },
            CursorLineNr = { fg = colors.pink },
            DiagnosticUnderlineError = { style = { "undercurl" } },
            TelescopeSelection = { fg = colors.crust, bg = colors.pink, style = { "bold" } },
            TelescopeSelectionCaret = { fg = colors.pink, bg = colors.pink },
            TelescopePreviewLine = { bg = colors.pink, fg = colors.crust, style = { "bold" } },
            TelescopePromptPrefix = { fg = colors.pink },
            SnacksPickerListCursorLine = { bg = colors.pink, fg = colors.crust, style = { "bold" } },
            SnacksPickerPreviewCursorLine = { bg = colors.pink, fg = colors.crust, style = { "bold" } },
            Search = { bg = colors.peach, fg = colors.crust, style = { "bold" } },
            IlluminatedWordRead = { bg = colors.surface1 },
            IlluminatedWordWrite = { bg = colors.surface1 },
            IlluminatedWordText = { bg = colors.surface1 },
            LspSignatureActiveParameter = { bg = colors.peach, fg = colors.crust, style = { "bold" } },
          }
        end,
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    event = "VeryLazy",
    opts = {
      tools = {
        hover_actions = {
          replace_builtin_hover = false,
        },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    event = "VeryLazy",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
}
