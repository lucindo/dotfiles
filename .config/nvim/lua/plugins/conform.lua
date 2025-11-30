-- Helper function for conform.nvim
local function conform_callback(err, _)
	if err then
		vim.notify("Formatting failed: " .. err, vim.log.levels.ERROR)
	else
		if vim.g.replace_tabs then
			vim.notify("Formatting done, executing retab", vim.log.levels.INFO)
			vim.cmd("retab!")
		end
	end
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					bufnr = 0,
					async = true,
					lsp_format = "fallback",
				}, conform_callback)
			end,
			mode = "",
			desc = "Format Buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			python = { "isort", "black" },
			toml = { "taplo" },
			markdown = { "prettier" },
			sh = { "shfmt" },
			yaml = { "prettier" },
			javascript = { "prettier", name = "dprint", timeout_ms = 1000, lsp_format = "fallback" },
			json = { "prettier", name = "dprint", timeout_ms = 1000, lsp_format = "fallback" },
			jsonc = { "prettier", name = "dprint", timeout_ms = 1000, lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- For filetypes without a formatter:
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = { "-style=file", "-fallback-style=Microsoft" },
			},
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				timeout_ms = 1000,
				lsp_format = "fallback",
				async = false,
			}, conform_callback
		end,
	},
}
