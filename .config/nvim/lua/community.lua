-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- programming
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- editing
  { import = "astrocommunity.editing-support.undotree" },
  -- theme & looks
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  -- navigation
  { import = "astrocommunity.recipes.heirline-tabline-buffer-number" },
  { import = "astrocommunity.motion.leap-nvim" },
}
