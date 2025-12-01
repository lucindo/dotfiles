--
-- To Enable this configuratio set
-- vim.g.enable_avante = true
-- on config/options.lua
--
-- To use your Antopric subscription
-- change `avante_provider` bellow
-- to claude and make sure to have
-- your key on environment var:
-- `AVANTE_ANTHROPIC_API_KEY`
--

local avante_provider = "openai" -- "claude"
local avante_options = {
	provider = avante_provider,
	mode = "agentic",
	auto_suggestions_provider = avante_provider,
	windows = {
		sidebar_header = {
			rounded = false,
		},
	},
	providers = {
		openai = {
			endpoint = "http://127.0.0.1:8181/v1",
			api_key_name = "",
			timeout = 30000,
			model = "qwen-7b-default",
		},
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
	},
}

return {
	"yetone/avante.nvim",
	enabled = vim.g.enable_avante,
	build = "make",
	event = "VeryLazy",
	version = false,
	opts = avante_options,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional
		"nvim-telescope/telescope.nvim",
		"saghen/blink.nvim",
		"nvim-mini/mini.nvim", -- make sure mini is loaded to provide icons
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
