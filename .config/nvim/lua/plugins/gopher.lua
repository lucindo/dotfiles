return {
	"olexsmir/gopher.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod", "gowork", "gotmpl" },
	opts = {},
	build = function()
		vim.cmd([[silent! GoInstallDeps]])
	end,
}
