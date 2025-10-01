return {
	"mhartington/formatter.nvim",
	dependencies = {
		{"mason-org/mason.nvim"},
		{"mason-org/mason-registry"},
	},
	config = function()
		--TODO: Use mason to install dependencies, stylua
		local m_registry = require("mason-registry")
		local deps = { "stylua", "shfmt" }
		for _, dep in ipairs(deps) do
			if m_registry.is_installed(dep) == false then
				m_registry.get_package(dep):install()
			end
		end

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
				sh = {
					require("formatter.filetypes.sh").shfmt,
					function()
						return {
							exe = "shfmt",
							args = { "-i", vim.opt.shiftwidth },
							stdin = true,
						}
					end,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
		local FormatAutoGroup = vim.api.nvim_create_augroup("vimrc", { clear = false })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = FormatAutoGroup,
			command = "FormatWrite",
		})
	end,
}
