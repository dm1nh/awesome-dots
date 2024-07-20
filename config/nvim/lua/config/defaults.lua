local M = {}

M.icons = {
	diagnostics = {
		ERROR = "󰃤",
		WARN = "󰈻",
		INFO = "󱈈",
		HINT = "󱠂",
	},
	git = {
		branch = "󰘬",
		add = "+",
		change = "~",
		delete = "-",
	},
	kinds = {
		Array = "󰛡 ",
		Boolean = "󰟡 ",
		Class = "󰙅 ",
		Codeium = "󰈮 ",
		Color = "󰏘 ",
		Control = "󰺵 ",
		Collapsed = "󰁄 ",
		Constant = "󰏿 ",
		Constructor = "󱌣 ",
		Copilot = " ",
		Enum = "󰸼 ",
		EnumMember = "󰸾 ",
		Event = "󰈸 ",
		Field = "󰆧 ",
		File = "󰈙 ",
		Folder = "󰉋 ",
		Function = "󰡱 ",
		Interface = "󰕓 ",
		Key = "󰌏 ",
		Keyword = "󰌆 ",
		Method = "󰡱 ",
		Module = "󰐱 ",
		Namespace = "󰅩 ",
		Null = "󰟢 ",
		Number = "󰎤 ",
		Object = "󰇞 ",
		Operator = "󰿉 ",
		Package = "󰏓 ",
		Property = "󰆧 ",
		Reference = "󰑨 ",
		Snippet = "󰅱 ",
		String = "󰥛 ",
		Struct = "󰌨 ",
		TabNine = "󰋙 ",
		Text = "󰯂 ",
		TypeParameter = "󰅴 ",
		Unit = "󰑭 ",
		Value = "󱢏 ",
		Variable = "󱊹 ",
	},
}

M.override_icons = {
	directory = {
		[".git"] = {
			glyph = "󱧴",
			hl = "MiniIconsOrange",
		},
		["lua"] = {
			glyph = "󱁿",
			hl = "MiniIconsBlue",
		},
		["node_modules"] = {
			glyph = "󰉍",
			hl = "MiniIconsGreen",
		},
	},
	file = {
		["astro.config.mjs"] = {
			glyph = "",
			hl = "MiniIconsAzure",
		},
		[".eslintrc.js"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		[".eslintrc.json"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		[".eslintrc.cjs"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		[".eslintrc.yaml"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		[".eslintrc.yml"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		["eslint.config.js"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		["eslint.config.mjs"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		["eslint.config.cjs"] = {
			glyph = "󰱺",
			hl = "MiniIconsPurple",
		},
		[".gitignore"] = {
			glyph = "󰊢",
			hl = "MiniIconsGrey",
		},
		[".luacheckrc"] = {
			glyph = "󰒓",
			hl = "MiniIconsCyan",
		},
		["init.lua"] = {
			glyph = "",
			hl = "MiniIconsBlue",
		},
		[".nvmrc"] = {
			glyph = "󰋙",
			hl = "MiniIconsGreen",
		},
		["package.json"] = {
			glyph = "󰋘",
			hl = "MiniIconsRed",
		},
		[".prettierrc"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.json"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.yml"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.yaml"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.json5"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.js"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		["prettier.config.js"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.mjs"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		["prettier.config.mjs"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.cjs"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		["prettier.config.cjs"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".prettierrc.toml"] = {
			glyph = "󰬗",
			hl = "MiniIconsCyan",
		},
		[".stylua.toml"] = {
			glyph = "󰬚",
			hl = "MiniIconsCyan",
		},
		["stylua.toml"] = {
			glyph = "󰬚",
			hl = "MiniIconsCyan",
		},
		["tsconfig.json"] = {
			glyph = "󰘦",
			hl = "MiniIconsBlue",
		},
		["tailwind.config.js"] = {
			glyph = "󱏿",
			hl = "MiniIconsCyan",
		},
		["tailwind.config.mjs"] = {
			glyph = "󱏿",
			hl = "MiniIconsCyan",
		},
		["tailwind.config.cjs"] = {
			glyph = "󱏿",
			hl = "MiniIconsCyan",
		},
		["tailwind.config.ts"] = {
			glyph = "󱏿",
			hl = "MiniIconsCyan",
		},
		["webpack"] = {
			glyph = "󰜫",
			hl = "MiniIconsBlue",
		},
		["README.md"] = {
			glyph = "",
			hl = "MiniIconsYellow",
		},
		["readme.md"] = {
			glyph = "",
			hl = "MiniIconsYellow",
		},
	},
	extension = {
		["cjs"] = {
			glyph = "󰌞",
			hl = "MiniIconsYellow",
		},
		["mjs"] = {
			glyph = "󰌞",
			hl = "MiniIconsYellow",
		},
		["js"] = {
			glyph = "󰌞",
			hl = "MiniIconsYellow",
		},
		["test.js"] = {
			glyph = "󰳪",
			hl = "MiniIconsYellow",
		},
		["spec.js"] = {
			glyph = "󰳪",
			hl = "MiniIconsYellow",
		},
		["test.jsx"] = {
			glyph = "󰳪",
			hl = "MiniIconsCyan",
		},
		["spec.jsx"] = {
			glyph = "󰳪",
			hl = "MiniIconsCyan",
		},
		["log"] = {
			glyph = "󰯂",
			hl = "MiniIconsGrey",
		},
		["md"] = {
			glyph = "",
			hl = "MiniIconsGrey",
		},
		["mdx"] = {
			glyph = "",
			hl = "MiniIconsOrange",
		},
		["pdf"] = {
			glyph = "󰈦",
			hl = "MiniIconsRed",
		},
		["prisma"] = {
			glyph = "",
			hl = "MiniIconsGrey",
		},
		["sol"] = {
			glyph = "󱓻",
			hl = "MiniIconsCyan",
		},
		["svg"] = {
			glyph = "󰜡",
			hl = "MiniIconsYellow",
		},
		["ts"] = {
			glyph = "󰛦",
			hl = "MiniIconsBlue",
		},
		["d.ts"] = {
			glyph = "󰛦",
			hl = "MiniIconsGrey",
		},
		["test.ts"] = {
			glyph = "󰳪",
			hl = "MiniIconsBlue",
		},
		["spec.ts"] = {
			glyph = "󰳪",
			hl = "MiniIconsBlue",
		},
		["test.tsx"] = {
			glyph = "󰳪",
			hl = "MiniIconsBlue",
		},
		["spec.tsx"] = {
			glyph = "󰳪",
			hl = "MiniIconsBlue",
		},
		["txt"] = {
			glyph = "󰎞",
			hl = "MiniIconsGrey",
		},
		["xml"] = {
			glyph = "󰗀",
			hl = "MiniIconsOrange",
		},
		["yaml"] = {
			glyph = "󰒓",
			hl = "MiniIconsAzure",
		},
		["yml"] = {
			glyph = "󰒓",
			hl = "MiniIconsAzure",
		},
	},
	filetype = {
		lua = {
			glyph = "󰢱",
			hl = "MiniIconsBlue",
		},
	},
}

return M
