return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	opts = {
		flavour = "frappe",
		no_italic = true, -- Force no italic
		no_bold = true, -- Force no bold
		no_underline = true, -- Force no underline
		styles = {
			comments = {},
			conditionals = {},
			-- conditionals = { "italic" },
		},
		integrations = {
			gitsigns = {
				enabled = true,
				transparent = false,
			},
			treesitter_context = true,
			fidget = true,
			which_key = true,
			blink_cmp = {
				style = "bordered",
			},
			mini = {
				enabled = true,
				indentscope_color = "lavender",
			},
			lsp_trouble = true,
			mason = true,
		},
		-- Remove white underline on treesitter context
		---@diagnostic disable-next-line
		custom_highlights = function(colors)
			return {
				TreesitterContextBottom = { style = {} },
			}
		end,
	},
	config = function(_, options)
		require("catppuccin").setup(options)
		vim.cmd([[colorscheme catppuccin-frappe]])
	end,
}
