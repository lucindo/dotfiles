return {
	{
		"tpope/vim-fugitive",
		config = function()
			local telescope = require("telescope.builtin")
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [s]tatus" })
			vim.keymap.set("n", "<leader>gB", telescope.git_branches, { desc = "[G]it [B]ranches (Search)" })
			vim.keymap.set("n", "<leader>gH", telescope.git_commits, { desc = "[G]it commit [H]istory (Search)" })
			vim.keymap.set("n", "<leader>gh", telescope.git_bcommits, { desc = "[G]it commit [h]istory (Buffer)" })
			vim.keymap.set("n", "<leader>gf", telescope.git_files, { desc = "[G]it [f]ind (Search git files)" })
			vim.keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "[G]it [d]iff" })
			vim.keymap.set("n", "<leader>ga", vim.cmd.Gwrite, { desc = "[G]it [a]dd" })
			vim.keymap.set("n", "<leader>gc", function()
				vim.cmd("Git commit")
			end, { desc = "[G]it [c]ommit" })
			vim.keymap.set("n", "<leader>gp", function()
				vim.cmd("Git push")
			end, { desc = "[G]it [p]ush" })
			vim.keymap.set("n", "<leader>gP", function()
				vim.cmd("Git pull")
			end, { desc = "[G]it [P]ull" })
			vim.keymap.set("n", "<leader>gl", function()
				vim.cmd("Git log")
			end, { desc = "[G]it [l]log" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
	},
}
