return {
	"stevearc/aerial.nvim",
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- "nvim-tree/nvim-web-devicons", -- using mini.icons
	},
	config = function()
		require("aerial").setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		-- Use command "AerialToggle! left" to open it on the left side. The '!' mantain the focus
		-- on current buffer.
		vim.keymap.set("n", "<leader>to", "<cmd>AerialToggle<CR>", { desc = "[T]oggle [O]utline" })
		vim.keymap.set("n", "<leader>ts", "<cmd>AerialNavToggle<CR>", { desc = "[T]oggle [S]ymbol Outline" })
	end,
}
