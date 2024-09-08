local wk = require("which-key")
wk.add({
	{ "<leader>c", group = "Cargo" },
	{ "<leader>d", group = "Debugger" },
	{ "<leader>h", group = "Git" },
	{ "<leader>ht", group = "Toggle" },
	{ "<leader>f", group = "Find" },
	{ "<leader>l", group = "LaTeX" },
	
	{ "<leader>r", desc = "Rename Symbol" },
	{ "<leader>a", desc = "Code Action" },
	{ "gd", desc = "Go to Definition" },
	{ "gD", desc = "Go to Declaration" },
	{ "gI", desc = "Go to Implementation" },
	{ "gr", desc = "Go to Next Reference" },
	{ "<leader>D", desc = "Type Definition" },
	{ "<leader>s", desc = "Search Document Symbols" },
	{ "<leader>S", desc = "Search Dynamic Workspace Symbols" }
})
