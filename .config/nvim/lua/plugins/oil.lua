return {
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {},
		config = function()
			require("oil").setup({
				default_file_explorer = true, -- Replaces Ex
				use_default_keymaps = true,
				delete_to_trash = false,
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".git"
					end,
				},
				columns = { "icon", "permissions", "size", "mtime" },
				keymaps = { ["<Esc>"] = "actions.close" },
				float = {
					padding = 0,
					max_width = math.floor(vim.o.columns * 0.8),
					max_height = math.floor(vim.o.lines * 0.8),
				},
				win_options = {
					signcolumn = "yes:2",
					colorcolumn = "",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					wrap = false,
				},
				confirmation = { border = "rounded" },
			})
			vim.keymap.set({ "n", "v" }, "<leader>te", require("oil").toggle_float, { desc = "Toggle file [e]xplorer" })
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
