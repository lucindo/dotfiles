-- Key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlights on search when pressing <Esc> in normal mode. See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = false, silent = true })

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Better paste behavior
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Move lines up/down (Alt/Option)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Back to Netrw
vim.keymap.set({ "n", "v" }, "<leader>te", vim.cmd.Ex, { desc = "[T]oggle file [e]xplorer" })

-- Little one from Primeagen to mass replace string in a file
vim.keymap.set(
	"n",
	"<leader>R",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ silent = false, desc = "[R]eplace word on point" }
)

-- Toggle auto format on save
vim.keymap.set({ "n", "v" }, "<leader>tf", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
end, { desc = "[T]oggle Auto[f]ormat on save" })

-- <C-l> to center the screen
vim.keymap.set({"n", "v"}, "<C-l>", ":normal! zz<CR>", { desc = "Center screen"})

-- Window resizing
vim.keymap.set("n", "<leader><left>", ":vertical resize +20<cr>", { desc = "Resize to the left" })
vim.keymap.set("n", "<leader><right>", ":vertical resize -20<cr>", { desc = "Resize to the right" })
vim.keymap.set("n", "<leader><up>", ":resize +10<cr>", { desc = "Resize Up" })
vim.keymap.set("n", "<leader><down>", ":resize -10<cr>", { desc = "Resize Down" })
