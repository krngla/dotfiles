return {
	"mhartington/formatter.nvim",
	dependencies = {
		--"StyLua"
	},
	config = function()
		local util = require("formatter.util")
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
					function()
						if util.get_current_buffer_file_name() == "special.lua" then
							return nil
						end
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
					function()
						return {
							exe = "gofmt",
							stdin = true,
						}
					end,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
		local FormatAutoGroup = vim.api.nvim_create_augroup("vimrc", { clera = flase })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = FormatAutoGroup,
			command = "FormatWrite",
		})
	end,
}
