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
				"cpp",
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
		opts = {
			enable = vim.g.code_context,
			mode = "cursor",
			separator = nil,
			line_numbers = true,
			min_window_height = 40,
			max_lines = 4,
			trim_scope = "outer",
			zindex = 20,
			on_attach = nil,
			multiwindow = false,
		},
		keys = {
			{ "<leader>tc", ":TSContext toggle<CR>", desc = "[T]oggle Treesitter [C]ontext" },
		},
	},
}
