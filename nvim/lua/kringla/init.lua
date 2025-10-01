require("kringla.opts")
require("kringla.lsp")
--Keymaps
vim.g.mapleader = " "
vim.keymap.set({ "n", "i", "v" }, "<Left>", function()
	print("Use h")
end)
vim.keymap.set({ "n", "i", "v" }, "<Right>", function()
	print("Use l")
end)
vim.keymap.set({ "n", "i", "v" }, "<Up>", function()
	print("Use k")
end)
vim.keymap.set({ "n", "i", "v" }, "<Down>", function()
	print("Use j")
end)

vim.keymap.set("n", "<leader>h", "<Left>")
vim.keymap.set("n", "<leader>l", "<Right>")
vim.keymap.set("n", "<leader>k", "<Up>")
vim.keymap.set("n", "<leader>j", "<Down>")

---#bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
--vim.cmd([[colorscheme tokyonight-night]])
