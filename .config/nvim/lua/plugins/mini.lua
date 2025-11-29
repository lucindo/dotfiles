return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		-- icons, replace nvim_web_devicons
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		-- auto pairs
		require("mini.pairs").setup()

		-- replace gitsigns
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {
					add = "┃",
					change = "┃",
					delete = "_",
				},
			},
		})

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup({
			-- mappings = {
			--   add = "sa",
			--   delete = "sd",
			--   find = "gsf",
			--   find_left = "gsF",
			--   highlight = "gsh",
			--   replace = "gsr",
			--   update_n_lines = "gsn",
			-- },
		})

		-- Better comment support
		--
		--  - gc   - Toggle comment (works like gcip) for visual and normal modes
		--  - gcc  - Toggle comment for the current line
		--  - gc   - Toggle comment on visual selection
		require("mini.comment").setup()

		-- better jump capabilities
		require("mini.jump").setup()

		-- Stauts line
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = false })
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- override vim.notify and show lsp info
		-- require("mini.notify").setup({
		-- 	content = {
		-- 		format = function(notif)
		-- 			return notif.msg
		-- 		end,
		-- 	},
		-- 	window = {
		-- 		config = function()
		-- 			local has_statusline = vim.o.laststatus > 0
		-- 			local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
		--
		-- 			return {
		-- 				border = "rounded",
		-- 				col = vim.o.columns,
		-- 				row = vim.o.lines - pad,
		-- 				anchor = "SE",
		-- 				title = "",
		-- 			}
		-- 		end,
		-- 	},
		-- })
		-- MiniNotify.make_notify()
	end,
}
