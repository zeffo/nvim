-- Overrides for astronvim default plugins
-- Blink-cmp, Neotree, snacks
local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end


return 
  {
    { -- optional saghen/blink.cmp completion source
      "Saghen/blink.cmp",
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
        keymap = {
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-N>"] = { "select_next", "show" },
          ["<C-P>"] = { "select_prev", "show" },
          ["<C-J>"] = { "select_next", "fallback" },
          ["<C-K>"] = { "select_prev", "fallback" },
          ["<C-U>"] = { "scroll_documentation_up", "fallback" },
          ["<C-D>"] = { "scroll_documentation_down", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = {
            "select_next",
            function(cmp)
              if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
            end,
            "fallback",
          },
          ["<S-Tab>"] = {
            "select_prev",
            function(cmp)
              if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
            end,
            "fallback",
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
            image = function(item) return { print(item) } end,
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
          }
        }
      }
    }
  }
