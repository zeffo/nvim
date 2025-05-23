-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "catppuccin",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    status = {
      colors = {
        mode_fg = "#11111b",
        visual = "#cba6f7",
        insert = "#f5c2e7",
        normal = "#fab387",
        section_bg = "#45475a",
        section_fg = "#f5c2e7",
        buffer_bg = "#313244",
        buffer_active_bg = "#f5c2e7",
        buffer_visible_bg = "#f5c2e7",
        buffer_active_fg = "#11111b",
        buffer_visible_fg = "#11111b",
      },
      separators = {
        left = { " ", " " }, -- separator for the left side of the statusline
        right = { " ", " " }, -- separator for the right side of the statusline
        tab = { "", "" },
        -- tab = { "", "" },
      },
    },
  },
}
