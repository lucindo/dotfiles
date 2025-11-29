return {
	-- Unit testing
	"nvim-neotest/neotest",
	keys = {
		{ "<leader>Tr", "<cmd>Neotest run<cr>", desc = "Run Test" },
		{ "<leader>Ts", "<cmd>Neotest summary<cr>", desc = "Summary Toggle" },
		{ "<leader>To", "<cmd>Neotest output<cr>", desc = "Show test output" },
		{ "<leader>Tp", "<cmd>Neotest output-panel<cr>", desc = "Show output panel" },
		{
			"<leader>Td",
			function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
			desc = "Run test with DAP (debug)",
		},
	},
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"fredrikaverpil/neotest-golang",
			build = function()
				vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
			end,
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")({
					runner = "gotestsum",
				}),
			},
		})
	end,
}
