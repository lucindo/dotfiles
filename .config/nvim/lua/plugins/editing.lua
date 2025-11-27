-- Helper plugins to assist on editing text and code

-- Helper function for conform.nvim
local function conform_callback(err, _)
  if err then
    vim.notify("Formatting failed: " .. err, vim.log.levels.ERROR)
  else
    if vim.g.replace_tabs then
      vim.notify("Formatting done, executing retab", vim.log.levels.INFO)
      vim.cmd "retab!"
    end
  end
end

return {
  {
    -- Detect tabstop and shiftwidth automatically
    "NMAC427/guess-indent.nvim",
  },
  {
    -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            bufnr = 0,
            async = true,
            lsp_format = "fallback",
          }, conform_callback)
        end,
        mode = "",
        desc = "Format Buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        python = { "isort", "black" },
        toml = { "taplo" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        yaml = { "prettier" },
        javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
        -- For filetypes without a formatter:
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
          async = false,
        },
          conform_callback
      end,
    },
  },
  {
    -- Autopairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    -- Editing motions extras from mini.nvim
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Better comment support
      --
      --  - gc   - Toggle comment (works like gcip) for visual and normal modes
      --  - gcc  - Toggle comment for the current line
      --  - gc   - Toggle comment on visual selection
      require("mini.comment").setup()

      -- Moving text with arrows (hjkl configured on keymaps.lua)
      require("mini.move").setup {
        mappings = {
          left = "<S-left>",
          right = "<S-right>",
          down = "<S-down>",
          up = "<S-up>",

          line_left = "<S-left>",
          line_right = "<S-right>",
          line_down = "<S-down>",
          line_up = "<S-up>",
        },
      }
    end,
  },
  {
    -- Autocompletion
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      "folke/lazydev.nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then return end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
          },
        },
        opts = {},
      },
    },
    opts = {
      keymap = {
        preset = "default",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "lua" },
      signature = { enabled = true },
    },
  },
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "python",
        "go",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    -- Undo Tree
    "mbbill/undotree",
    config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" }) end,
  },
}
