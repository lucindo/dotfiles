-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- languages
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.yaml" },
  -- theme & looks
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  -- navigation
  { import = "astrocommunity.recipes.heirline-tabline-buffer-number" },
  { import = "astrocommunity.motion.leap-nvim" },
}
