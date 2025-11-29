-- Utilities
return {
  {
    -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable "make" == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-tree/nvim-web-devicons",
        enabled = true,
      },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          layout_config = {
            horizontal = {
              preview_width = 0.6,
            },
            vertical = {
              preview_height = 0.7,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "List existing buffers" })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        "n",
        "<leader>s/",
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          }
        end,
        { desc = "[S]earch [/] in Open Files" }
      )
      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set(
        "n",
        "<leader>sn",
        function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
        { desc = "[S]earch [N]eovim files" }
      )
    end,
  },
  {
    -- Frecency algorithm for Telescope
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    config = function() require("telescope").load_extension "frecency" end,
  },
  {
    -- Search undo history on telescope
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      {
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "[S]earch [U]ndo history",
      },
    },
    opts = {
      extensions = {
        undo = {},
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },
  {
    -- [Programming] Search hierarchy of function calls (in and out)
    "jmacadie/telescope-hierarchy.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        -- Choose your own keys, this works for me
        "<leader>si",
        "<cmd>Telescope hierarchy incoming_calls<cr>",
        desc = "LSP: [S]earch [I]ncoming Calls",
      },
      {
        "<leader>so",
        "<cmd>Telescope hierarchy outgoing_calls<cr>",
        desc = "LSP: [S]earch [O]utgoing Calls",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        hierarchy = {
          layout_strategy = "horizontal",
          multi_depth = 5, -- How many layers deep should a multi-expand go?
          initial_multi_expand = false, -- Run a multi-expand on open? If false, will only expand one layer deep by default
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension "hierarchy"
    end,
  },
  {
    -- Better file explorer than Ex
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-mini/mini.icons",
    },
    lazy = false,
    opts = {},
    config = function()
      require("oil").setup {
        default_file_explorer = true,
        use_default_keymaps = true,
        delete_to_trash = false,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _) return name == ".git" end,
        },
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        keymaps = { ["<Esc>"] = "actions.close" },
        float = {
          padding = 0,
          max_width = math.floor(vim.o.columns * 0.8),
          max_height = math.floor(vim.o.lines * 0.8),
        },
        win_options = {
          signcolumn = "no",
          colorcolumn = "",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          wrap = false,
        },
        confirmation = { border = "rounded" },
      }
      vim.keymap.set({ "n", "v" }, "<leader>te", require("oil").toggle_float, { desc = "Toggle file [e]xplorer" })
    end,
  },
  { -- Code Outline
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup {
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      }
      -- Use command "AerialToggle! left" to open it on the left side. The '!' mantain the focus
      -- on current buffer.
      vim.keymap.set("n", "<leader>to", "<cmd>AerialToggle<CR>", { desc = "[T]oggle [O]utline" })
      vim.keymap.set("n", "<leader>ts", "<cmd>AerialNavToggle<CR>", { desc = "[T]oggle [S]ymbol Outline" })
    end,
  },
  {
    -- Git support
    "tpope/vim-fugitive",
    config = function()
      local telescope = require "telescope.builtin"
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [s]tatus" })
      vim.keymap.set("n", "<leader>gB", telescope.git_branches, { desc = "[G]it [B]ranches (Search)" })
      vim.keymap.set("n", "<leader>gH", telescope.git_commits, { desc = "[G]it commit [H]istory (Search)" })
      vim.keymap.set("n", "<leader>gh", telescope.git_bcommits, { desc = "[G]it commit [h]istory (Buffer)" })
      vim.keymap.set("n", "<leader>gf", telescope.git_files, { desc = "[G]it [f]ind (Search git files)" })
      vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [d]iff" })
      vim.keymap.set("n", "<leader>ga", vim.cmd.Gwrite, { desc = "[G]it [a]dd" })
      vim.keymap.set("n", "<leader>gc", function() vim.cmd "Git commit" end, { desc = "[G]it [c]ommit" })
      vim.keymap.set("n", "<leader>gp", function() vim.cmd "Git push" end, { desc = "[G]it [p]ush" })
      vim.keymap.set("n", "<leader>gP", function() vim.cmd "Git pull" end, { desc = "[G]it [P]ull" })
      vim.keymap.set("n", "<leader>gl", function() vim.cmd "Git log" end, { desc = "[G]it [l]log" })
    end,
  },
  {
    -- Better dignostics
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    -- Better terminal support
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = function()
      require("toggleterm").setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 8
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        direction = "horizontal",
      }
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
      vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "[T]oggle [t]erm" })
    end,
  },
  {
    -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    enabled = function() return vim.g.training_wheels end,
    event = "VimEnter",
    opts = {
      delay = 500,
      icons = {
        mappings = false,
      },
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>x", group = "Trouble (Quickfix)" },
        { "<leader>g", group = "[G]it" },
        { "<leader>d", group = "[D]ebug/Test" },
      },
    },
  },
  {
    -- Unit testing
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      {
        "nvim-treesitter/nvim-treesitter", -- Optional, but recommended
        build = function() vim.cmd ":TSUpdate go" end,
      },
      {
        "fredrikaverpil/neotest-golang",
        version = "*", -- Optional, but recommended; track releases
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
      },
    },
    config = function()
      local config = {
        runner = "gotestsum", -- Optional, but recommended
      }
      require("neotest").setup {
        adapters = {
          require "neotest-golang" {
            dap = { justMyCode = false },
          },
        },
      }
      vim.keymap.set(
        "n",
        "<leader>dr",
        function() require("neotest").run.run { suite = false, testify = true } end,
        { desc = "Test: Running Nearest Test" }
      )
      vim.keymap.set(
        "n",
        "<leader>dv",
        function() require("neotest").summary.toggle() end,
        { desc = "Test: Summary Toggle" }
      )
      vim.keymap.set(
        "n",
        "<leader>ds",
        function() require("neotest").run.run { suite = true, testify = true } end,
        { desc = "Test: Running Test Suite" }
      )
      vim.keymap.set(
        "n",
        "<leader>dd",
        function() require("neotest").run.run { suite = false, testify = true, strategy = "dap" } end,
        { desc = "Test: Debug Nearest Test" }
      )
      vim.keymap.set(
        "n",
        "<leader>do",
        function() require("neotest").output.open() end,
        { desc = "Test: Open test output" }
      )
      vim.keymap.set(
        "n",
        "<leader>da",
        function() require("neotest").run.run(vim.fn.getcwd()) end,
        { desc = "Test: Open test output" }
      )
    end,
  },
}
