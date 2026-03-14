return {

	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'master',
		build = ":TSUpdate",
		main = 'nvim-treesitter.config',
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-context" },
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				ensure_installed = { "c", "zig", "javascript", "go", "python", "lua", "bash",  "vimdoc", "tsx", "typescript", "json" },
			})
			require("treesitter-context").setup({ max_lines = 5 })
			vim.wo.foldexpr ='v:lua.vim.treesitter.foldexpr()'
		end,
	},
}
