require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		nix = { "nixfmt" },
		gd = { "gdformat" },
		cpp = { "clang-format" },
	},
})
