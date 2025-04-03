-- Overrides for astronvim default plugins
-- Blink-cmp, Neotree, snacks

return {
  { -- optional saghen/blink.cmp completion source
    "saghen/blink.cmp",
    event = "VeryLazy",
    opts = {
      completion = {
        menu = {
          auto_show = false,
        },
      },
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
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        prompt = "",
      },
      indent = {
        indent = {
          only_scope = true,
        },
      },
      dashboard = {
        preset = {
          header = ":3",
          keys = {
            { key = "f", desc = "find", action = ":lua Snacks.dashboard.pick('files')" },
            { key = "n", desc = "new", action = ":ene | startinsert" },
            { key = "g", desc = "search", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { key = "r", desc = "recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              key = "c",
              desc = "config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { key = "s", desc = "restore", section = "session" },
            { key = "L", desc = "lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { key = "q", desc = "quit", action = ":qa" },
          },
        },
        formats = {
          key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
          image = function(item) return { print(item) } end
        },
        sections = {
          -- {
          --   section = "image",
          --   source = "/e/Images/rocket/_20.png",
          --   height = 3,
          --   align = "right",
          --   padding = 1
          --
          -- },
          { section = "startup", gap = 2, padding = 2 },
          { section = "keys" },
        },
      },
    },
  },
}
