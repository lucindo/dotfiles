return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main", -- provides @function/@class/@loop/... queries for mini.ai
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-mini/mini.nvim",
		version = "*",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			-- Around/Inside textobjects, treesitter-aware.
			--  - vaf / dif - [A]round / [I]nside [F]unction
			--  - vac / dic - [C]lass
			--  - daa / cia - [A]rgument (parameter)
			--  - vao / dio - code block ([O]: if/for/while)
			-- Falls back to mini.ai builtins for ), ', ", t (tag), etc.
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
				},
			})

			-- Add/delete/replace surroundings. On `gs` prefix so flash keeps bare `s`.
			--  - gsaiw) - [A]dd surround [I]nner [W]ord with )
			--  - gsd'   - [D]elete surrounding '
			--  - gsr)'  - [R]eplace ) with '
			--  - gsaif) - surround [I]nner [F]unction with ) (uses the mini.ai object)
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "gsn",
				},
			})

			-- Better comment support
			--  - gc   - Toggle comment (works like gcip) for visual and normal modes
			--  - gcc  - Toggle comment for the current line
			require("mini.comment").setup()

			-- Status line
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = false })
			-- Uppercase the mode name (NORMAL instead of Normal)
			local section_mode = statusline.section_mode
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_mode = function(args)
				local mode, mode_hl = section_mode(args)
				return mode:upper(), mode_hl
			end
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
