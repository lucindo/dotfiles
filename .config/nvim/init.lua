--
-- Sources of inspiration (and full copy&paste) for this config:
--   > kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim
--   > nvim-lite: https://github.com/radleylewis/nvim-lite/tree/master
--   > AstroNvim, ThePrimeagen config & videos and many more
--
require("config.options")
require("config.autocmds")
require("config.keybinds")
-- lazy.nvim should be loaded after mapleader definition
require("config.lazy")
