return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	build = "cargo build --release",
	dependencies = {
		"onsails/lspkind.nvim", -- VS Code–style pictograms
	},
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			["<S-Tab>"] = { "show" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
					components = {
						kind_icon = {
							text = function(ctx)
								--local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
								local icon = require("lspkind").symbol_map[ctx.kind] or ""
								return icon .. ctx.icon_gap
							end,
						},
					},
				},
			},
			documentation = { auto_show = true },
			accept = {
				auto_brackets = {
					-- working nicely with autopairs-nvim
					enabled = true,
				},
			},
		},
		sources = {
			default = { "lsp", "path", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				lsp = { score_offset = 90 },
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
}
