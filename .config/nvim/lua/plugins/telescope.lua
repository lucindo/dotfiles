return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
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
					fzf = {},
					["ui-select"] = {},
				},
				pickers = {
					live_grep = {
						file_ignore_patterns = { "node_modules", ".git" },
						additional_args = function(_)
							return { "--hidden" }
						end,
					},
					find_files = {
						file_ignore_patterns = { "node_modules", ".git" },
						hidden = true,
					},
				},
			})
			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			local builtin = require("telescope.builtin")
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
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	--
	-- Telescope Plugins:
	--
	{
		-- Frecency algorithm for Telescope
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
	{
		-- Search undo history on telescope
		"debugloop/telescope-undo.nvim",
		dependencies = { { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } } },
		keys = { { "<leader>su", "<cmd>Telescope undo<cr>", desc = "[S]earch [U]ndo history" } },
		opts = { extensions = { undo = {} } },
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
	{
		-- [Programming] Search hierarchy of function calls (in and out)
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = { { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } } },
		keys = {
			{ "<leader>si", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "LSP: [S]earch [I]ncoming Calls" },
			{ "<leader>so", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "LSP: [S]earch [O]utgoing Calls" },
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				hierarchy = {
					layout_strategy = "horizontal",
					multi_depth = 5, -- How many layers deep should a multi-expand go?
					initial_multi_expand = false, -- Run a multi-expand on open? If false, will only expand one layer deep by default
				},
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("hierarchy")
		end,
	},
}
