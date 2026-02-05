-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Show cursor line only on active window
local cursorGrp = vim.api.nvim_create_augroup("cursor_line_group", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursorGrp,
	pattern = "*",
	command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = cursorGrp,
	pattern = "*",
	command = "setlocal nocursorline",
})

-- Remove number column from termonal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("term_open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.signcolumn = "no"
	end,
})

-- Wrap lines on text files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "plaintex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true -- Wrap at words, not characters
		vim.opt_local.formatoptions:append("t") -- Auto-wrap text using textwidth
		--vim.opt_local.textwidth = 80 -- Optional: set width for hard wraps
	end,
})
