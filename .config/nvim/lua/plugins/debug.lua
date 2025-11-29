return {
	"igorlfs/nvim-dap-view",
	dependencies = {
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{ "<leader>dt", "<cmd>DapViewToggle<cr>", desc = "Toggle View" },
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
		{ "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Watch" },
	},
	config = function()
		require("nvim-dap-virtual-text").setup({})
	end,
}
