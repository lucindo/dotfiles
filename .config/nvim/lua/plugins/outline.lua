return {
	"hedyhli/outline.nvim",
	config = function()
		-- Example mapping to toggle outline
		vim.keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

		require("outline").setup({
			outline_window = {
				position = "left",
				width = 35,
				auto_close = false,
				focus_on_open = false,
				relative_width = false,
				no_provider_message = "",
			},
		})
	end,
}
