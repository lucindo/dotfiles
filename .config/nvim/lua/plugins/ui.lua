-- UI Plugins
return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = false,
      -- Uncomment bellow to display signs as chars
      -- signs = {
      --     add = { text = "+" },
      --     change = { text = "~" },
      --     delete = { text = "_" },
      --     topdelete = { text = "‾" },
      --     changedelete = { text = "~" },
      -- },
    },
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git: [T]oggle git [b]lame (line)" })
          map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Git: [T]oggle git [w]ord diff" })
          map("n", "<leader>gb", function() gitsigns.blame() end, { desc = "[G]it [B]lame (file)" })
        end,
      }
    end,
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- Theme
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require("catppuccin").setup {
        flavour = "frappe",
        no_italic = true, -- Force no italic
        no_bold = true, -- Force no bold
        no_underline = true, -- Force no underline
        styles = {
          comments = {},
          conditionals = {},
          -- conditionals = { "italic" },
        },
        integrations = {
          gitsigns = {
            enabled = true,
            transparent = false,
          },
          treesitter_context = true,
          fidget = true,
          which_key = true,
          blink_cmp = {
            style = "bordered", -- Or "default", "flat"
          },
          mini = {
            enabled = true,
            indentscope_color = "lavender",
          },
        },
        ---@diagnostic disable-next-line
        custom_highlights = function(colors)
          return {
            TreesitterContextBottom = { style = {} },
          }
        end,
      }
      -- Load the colorscheme here.
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    -- Shows header context
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup {
        enable = true,
        mode = "cursor",
        separator = nil,
        line_numbers = true,
        min_window_height = 40,
        max_lines = 0,
        multiwindow = false,
      }
    end,
  },
  {
    -- Useful for getting pretty icons
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    -- mini.statusline
    --"nvim-mini/mini.statusline",
    "nvim-mini/mini.nvim",
    version = "*",
    config = function()
      local statusline = require "mini.statusline"
      statusline.setup { use_icons = true }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return "%2l:%-2v" end
    end,
  },
}
