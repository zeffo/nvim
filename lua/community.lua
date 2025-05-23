-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { dir = "/e/gitclones/astrocommunity/"}, -- enable for dev
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  -- import/override with your plugins folder
}
