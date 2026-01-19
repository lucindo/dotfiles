return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	build = "cargo build --release",
	dependencies = {
		"nvim-mini/mini.nvim",
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
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local mini_icon, _ = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
									if mini_icon then
										return mini_icon .. ctx.icon_gap
									end
								end

								--local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
								local icon = require("lspkind").symbol_map[ctx.kind] or ""
								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from mini.icons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local mini_icon, mini_hl =
										require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
									if mini_icon then
										return mini_hl
									end
								end
								return ctx.kind_hl
							end,
						},
						kind = {
							-- Optional, use highlights from mini.icons
							highlight = function(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local mini_icon, mini_hl =
										require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
									if mini_icon then
										return mini_hl
									end
								end
								return ctx.kind_hl
							end,
						},
					},
				},
			},
			documentation = { auto_show = true },
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
