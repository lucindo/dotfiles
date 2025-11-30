return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
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
	--
	-- Treesitter extra plugins
	--
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("treesitter-context").setup({
				enable = vim.g.code_context,
				mode = "cursor",
				separator = nil,
				line_numbers = true,
				min_window_height = 40,
				max_lines = 3,
				multiwindow = false,
			})
			vim.keymap.set("n", "<leader>tc", ":TSContext toggle<CR>", { desc = "[T]oggle Treesitter [C]ontext" })
		end,
	},
}
