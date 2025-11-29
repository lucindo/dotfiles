return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {},
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 8
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			direction = "horizontal",
		})
		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
		vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "[T]oggle [t]erm" })
	end,
}
