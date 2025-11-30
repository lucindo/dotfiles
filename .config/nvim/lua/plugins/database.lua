return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			{
				"kristijanhusak/vim-dadbod-ui",
				cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
			},
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		config = function()
			vim.g.db_ui_execute_on_save = 0 --do not execute on save
			vim.g.db_ui_win_position = "left"
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_icons = {
				expanded = {
					db = "▼",
					buffers = "▼",
					saved_queries = "▼",
					schemas = "▼",
					schema = "▼",
					tables = "▼",
					table = "▼",
				},
				collapsed = {
					db = "▶",
					buffers = "▶",
					saved_queries = "▶",
					schemas = "▶",
					schema = "▶",
					tables = "▶",
					table = "▶",
				},
				saved_query = "*",
				new_query = "+",
				tables = "~",
				buffers = "»",
				add_connection = "[+]",
				connection_ok = "✓",
				connection_error = "✕",
			}
		end,
	},
}
