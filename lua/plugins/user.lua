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
          alpha = true,
          mason = true,
          treesitter = true,
          notify = true,
          neotree = true,
          dadbod_ui = true,
          which_key = true,
          indent_blankline = true,
        },
        custom_highlights = function(colors)
          return {
            IncSearch = { bg = colors.pink, fg = colors.crust },
            FloatBorder = { fg = colors.pink },
            PmenuSel = { fg = colors.crust, bg = colors.pink },
            BlinkCmpScrollBarThumb = { bg = colors.mauve, fg = colors.mauve },
            BlinkCmpKind = { fg = colors.pink },
            BlinkCmpLabelMatch = { fg = colors.pink, style = {"bold"}},
            NeoTreeRootName = { fg = colors.pink },
            NeoTreeDirectoryName = { fg = colors.mauve },
            NeoTreeDirectoryIcon = { fg = colors.mauve },
            NeoTreeIndentMarker = { fg = colors.mauve },
            Visual = { bg = colors.mauve, fg = colors.crust },
            CursorLineNr = { fg = colors.pink },
            TelescopeSelection = { fg = colors.crust, bg = colors.pink, style = { "bold" } },
            TelescopeSelectionCaret = { fg = colors.pink, bg = colors.pink },
            TelescopePromptPrefix = { fg = colors.pink },
            DiagnosticUnderlineError = { style = { "undercurl" } },
          }
        end,
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts) opts.background_colour = "#000000" end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- opts.section.header.opts.hl = "SpecialChar"
      for _k, v in pairs(opts.section.buttons.val) do
        v.opts.hl = "Keyword"
        v.opts.hl_shortcut = "Error"
      end
      local gradient = {
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
        "@field",
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
          val = l,
          opts = { hl = gradient[i], position = "center" },
        }
        lines[i] = line
      end
      local header = {
        type = "group",
        val = lines,
        opts = { position = "center" },
      }
      opts.config.layout[2] = header
      opts.config.layout[6] = {
        type = "group",
        val = { { type = "text", val = " ", opts = { position = "center", hl = "SpecialChar" } } },
        opts = { position = "center" },
      }
    end,
  },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence").setup {
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "neovim :3", -- Text displayed when hovered over the Neovim image
        main_image = "neovim", -- Main image display (either "neovim" or "file")
        -- client_id           = "793271441293967371",    -- Use your own Discord application client id (not recommended)
        -- log_level           = nil,                     -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        -- debounce_timeout    = 10,                      -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        -- enable_line_number  = false,                   -- Displays the current line number instead of the current project
        -- blacklist           = {},                      -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        -- buttons             = true,                    -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        -- file_assets         = {},                      -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time = true, -- Show the timer

        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      }
    end,
  },
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_branch {},
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
        -- remove the 2nd mode indicator on the right
      }

      -- return the final configuration table
      return opts
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    event = 'VeryLazy',
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
  { -- optional saghen/blink.cmp completion source
    "saghen/blink.cmp",
    event = "VeryLazy",
    opts = {
      signature = { enabled = false },
      sources = {
        -- add vim-dadbod-completion to your completion providers
        default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      scope = {
        highlight = "SpecialChar",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      preset = "simple",
      hi = {
        mixing_color = "#1e1e2e",
      },
    },
  },
}
