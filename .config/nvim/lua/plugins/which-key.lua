return {
	"folke/which-key.nvim",
	enabled = function()
		return vim.g.training_wheels
	end,
	event = "VimEnter",
	opts = {
		delay = 500,
		icons = {
			mappings = false,
		},
		spec = {
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>x", group = "Trouble (Quickfix)" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>T", group = "[T]esting" },
		},
	},
}
