return {

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-context" },
			-- { "nvim-treesitter/playground" },
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				ensure_installed = { "c", "zig", "javascript", "go", "python", "lua", "bash",  "vimdoc" },
			})
			require("treesitter-context").setup({ max_lines = 5 })
			vim.wo.foldexpr ='v:lua.vim.treesitter.foldexpr()'
		end,
	},
}
