return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		-- icons, replace nvim_web_devicons
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

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

		-- Stauts line
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = false })
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
