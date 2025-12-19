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
        bg = "#181825",
        mode_fg = "#11111b",
        visual = "#cba6f7",
        insert = "#f5c2e7",
        normal = "#fab387",
        section_bg = "#181825",
        section_fg = "#f5c2e7",
        buffer_bg = "#313244",
        buffer_active_bg = "#f5c2e7",
        buffer_visible_bg = "#f5c2e7",
        buffer_active_fg = "#11111b",
        buffer_visible_fg = "#11111b",
        file_info_bg = "#f38ba8",
        file_info_fg = "#11111b",
        git_branch_bg = "#cba6f7",
        git_branch_fg = "#11111b",
        lsp_fg = "#cba6f7",
        treesitter_fg = "#f38ba8",
      },
      separators = {
        left = { " ", " " }, -- separator for the left side of the statusline
        right = { " ", " " }, -- separator for the right side of the statusline
        tab = { "", "" },
        -- tab = { "", "" },
      },
      attributes = {
        mode = { bold = true },
        file_info = { bold = true },
      },
      icon_highlights = {
        -- enable or disable breadcrumb icon highlighting
        breadcrumbs = true,
        -- Enable or disable the highlighting of filetype icons both in the statusline and tabline
        file_icon = {
          tabline = function(self) return self.is_active or self.is_visible end,
          statusline = true,
        },
      },
    },
  },
}
