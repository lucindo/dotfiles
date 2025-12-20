return {
	"folke/trouble.nvim",
	dependencies = {
		"folke/todo-comments.nvim",
	},
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false win.position=left<cr>", desc = "Symbols" },
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODO List" },
		{
			"<leader>xl",
			"<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
			desc = "LSP Definitions / references / ...",
		},
	},
}
