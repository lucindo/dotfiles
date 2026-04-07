return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		main = "nvim-treesitter",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
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
