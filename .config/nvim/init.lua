--
-- Sources of inspiration (and full copy&paste) for this config:
--   > kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim
--   > nvim-lite: https://github.com/radleylewis/nvim-lite/tree/master
--   > AstroNvim, ThePrimeagen config & videos and many more
--
require "config.options"
require "config.autocmds"
require "config.keybinds"
-- lazy.nvim should be loaded after mapleader definition
require "config.lazy"

-- Open fuzzy finder when nvim starts with no arguments
--
local sg = vim.api.nvim_create_augroup("startup", { clear = true })
-- check if nvim is reading from stdin (pipe?)
vim.api.nvim_create_autocmd("VimEnter", {
  group = sg,
  callback = function()
    for _, v in pairs(vim.v.argv) do
      if v == "-" then
        vim.g.read_from_stdin = 1
        break
      end
    end
  end,
})
-- check if nvim has no parans and open fuzzy finder if configured
vim.api.nvim_create_autocmd("UIEnter", {
  group = sg,
  callback = function()
    if
      vim.fn.argc() == 0
      and vim.api.nvim_buf_get_name(0) == ""
      and vim.g.read_from_stdin == nil
      and vim.g.finder_on_open
    then
      require("telescope.builtin").find_files()
    end
  end,
})
