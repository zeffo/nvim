-- vim.o.*

vim.o.relativenumber = true -- relative line numbers
vim.o.number = true -- absolute line numbers
vim.o.spell = false -- spellcheck
vim.o.shiftwidth = 2
vim.o.tabstop = 4
vim.o.backspace = "indent,eol,start,nostop" -- don't stop backspace at insert
vim.o.breakindent = true -- wrap indent to match  line start
vim.o.clipboard = "unnamedplus" -- connection to the system clipboard
vim.o.cmdheight = 0 -- hide command line unless needed
vim.o.completeopt = "menu,menuone,noselect" -- Options for insert mode completion
vim.o.confirm = true -- raise a dialog asking if you wish to save the current file(s)
vim.o.copyindent = true -- copy the previous indentation on autoindenting
vim.o.cursorline = true -- highlight the text line of the cursor
vim.o.diffopt = "algorithm:histogram,linematch:60" -- enable linematch diff algorithm
vim.o.expandtab = true -- enable the use of space in tab
vim.o.ignorecase = true -- case insensitive searching
vim.o.infercase = true -- infer cases in keyword completion
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- wrap lines at 'breakat'
vim.o.mouse = "a" -- enable mouse support
vim.o.preserveindent = true -- preserve indent structure as much as possible
vim.o.pumheight = 10 -- height of the pop up menu
vim.o.shiftround = true -- round indentation with `>`/`<` to shiftwidth
vim.o.shortmess = "ltToOCFsIc" -- disable search count wrap, startup messages, and completion messages
vim.o.showmode = false -- disable showing modes in command line
vim.o.showtabline = 2 -- always display tabline
vim.o.signcolumn = "yes" -- always show the sign column
vim.o.smartcase = true -- case sensitive searching
vim.o.splitbelow = true -- splitting a new window below the current one
vim.o.splitright = true -- splitting a new window at the right of the current one
vim.o.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.o.timeoutlen = 500 -- shorten key timeout length a little bit for which-key
vim.o.title = true -- set terminal title to the filename and path
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- length of time to wait before triggering the plugin
vim.o.virtualedit = "block" -- allow going past end of line in visual block mode
vim.o.wrap = false -- disable wrapping of lines longer than the width of window
vim.o.writebackup = false -- disable making a backup before overwriting a file

-- nushell compat
vim.o.shell = "nu"
vim.o.shelltemp = false
vim.o.shellredir = "out+err> %s"
vim.o.shellcmdflag = "--stdin --no-newline -c"
vim.o.shellxescape = ""
vim.o.shellxquote = ""
vim.o.shellquote = ""
vim.o.shellpipe = "| complete | tee { ($in.stdout + $in.stderr) | save -r -f %s }"
vim.o.makeprg = ""
vim.o.winborder = "rounded"

-- globals
vim.g.mapleader = " "

-- diagnostic
vim.diagnostic.config({
	underline = true,
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- lsp
vim.lsp.enable({
	"lua_ls",
	"stylua",
})
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)

-- lsp configs

-- plugins
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/rebelot/heirline.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- colorscheme
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	float = {
		transparent = true,
		solid = true,
	},
	integrations = {
		treesitter = true,
	},
	custom_highlights = function(colors)
		return {
			FloatBorder = { fg = colors.pink },
			Visual = { bg = colors.peach, fg = colors.crust },
			CursorLineNr = { fg = colors.pink },
			IncSearch = { bg = colors.pink, fg = colors.crust },
			DiagnosticUnderlineError = { style = { "undercurl" } },
			Search = { bg = colors.peach, fg = colors.crust, style = { "bold" } },
			LspSignatureActiveParameter = { bg = colors.peach, fg = colors.crust, style = { "bold" } },
			BlinkCmpScrollBarThumb = { bg = colors.mauve, fg = colors.mauve },
			BlinkCmpKind = { fg = colors.pink },
			BlinkCmpLabelMatch = { fg = colors.pink, style = { "bold" } },
			BlinkCmpMenuBorder = { fg = colors.pink },
			BlinkCmpMenuSelection = { fg = colors.crust, bg = colors.pink },
		}
	end,
})
vim.cmd.colorscheme("catppuccin-mocha")
COLORS = require("catppuccin.palettes").get_palette("mocha")

-- icons
require("mini.icons").setup()
require("gitsigns").setup({ auto_attach = true })

-- statusline

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local mode_map = {
	n = { "Normal", COLORS.peach },
	v = { "Visual", COLORS.mauve },
	i = { "Insert", COLORS.pink },
	V = { "Visual Block", COLORS.yellow },
}

local function get_mode_color(mode)
	local m = mode_map[mode]
	local color
	if m then
		color = m[2]
	else
		color = COLORS.red
	end
	return { fg = COLORS.crust, bg = color, bold = true }
end

local seps = { " ", " " }
-- default padding for a single component
local pad_one = { left = 0, right = 0 }

local function pad_string(str, padding)
	padding = padding or {}
	return str and str ~= "" and string.rep(" ", padding.left or 0) .. str .. string.rep(" ", padding.right or 0) or ""
end

local ModePill = {
	init = function(self)
		self.mode = vim.fn.mode(1)
		self.smode = self.mode:sub(1, 1)
		self.mode_color = get_mode_color(self.smode)
		self.sep_color = { fg = self.mode_color.bg }
	end,
	{
		provider = seps[1],
		hl = function(self)
			return self.sep_color
		end,
	},
	{
		provider = function(self)
			local m = mode_map[self.smode]
			local mode
			if m then
				mode = m[1]
			else
				mode = self.mode
			end

			return pad_string("%2(" .. mode .. "%)", pad_one)
		end,
		hl = function(self)
			return self.mode_color
		end,
	},
	{
		provider = seps[2],
		hl = function(self)
			return self.sep_color
		end,
	},
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

local FilePill = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	hl = { bg = COLORS.red, fg = COLORS.crust, bold = true },
}

local FilePillIcon = {
	init = function(self)
		self.icon, self.icon_color = require("mini.icons").get("file", self.filename)
	end,
	provider = function(self)
		return pad_string(self.icon, { right = 1 })
	end,
}

local FilePillName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return " [No Name] "
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return pad_string(filename)
	end,
}

local FilePillFlags = {
	provider = "",
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = pad_string("[+]", { right = 1 }),
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = pad_string("", { right = 1 }),
	},
}

FilePill = utils.surround(seps, COLORS.red, utils.insert(FilePill, FilePillIcon, FilePillName, FilePillFlags))

local GitBranchPill = {
	condition = conditions.is_git_repo,
	utils.surround(seps, COLORS.mauve, {

		init = function(self)
			self.status_dict = vim.b.gitsigns_status_dict
		end,

		hl = { fg = COLORS.crust, bg = COLORS.mauve },

		{ -- git branch name
			provider = function(self)
				return pad_string(" " .. self.status_dict.head, pad_one)
			end,
			hl = { bold = true },
		},
	}),
}

local GitDiffPill = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,
	hl = { fg = COLORS.crust, bg = COLORS.mauve },
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = COLORS.green, bold = true },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = COLORS.red, bold = true },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = COLORS.yellow, bold = true },
	},
}

local LSPPill = utils.surround(seps, COLORS.teal, {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return pad_string(" " .. table.concat(names, ", ") .. "", pad_one)
	end,
	hl = { fg = COLORS.crust, bg = COLORS.teal, bold = true },
})

local DiagnosticsPill = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR] .. " ",
		warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN] .. " ",
		info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO] .. " ",
		hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT] .. " ",
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{ provider = " " },
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = COLORS.red },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = COLORS.yellow },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = COLORS.teal },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = COLORS.sky },
	},
	{ provider = " " },
}

local statusline = { ModePill, FilePill, GitBranchPill, GitDiffPill, LSPPill, DiagnosticsPill }

require("heirline").setup({
	statusline = statusline,
})

-- completion
local function has_words_before()
	local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("blink.cmp").setup({
	completion = {
		menu = {
			auto_show = false,
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	keymap = {
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-N>"] = { "select_next", "show" },
		["<C-P>"] = { "select_prev", "show" },
		["<C-J>"] = { "select_next", "fallback" },
		["<C-K>"] = { "select_prev", "fallback" },
		["<C-U>"] = { "scroll_documentation_up", "fallback" },
		["<C-D>"] = { "scroll_documentation_down", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = {
			"select_next",
			function(cmp)
				if has_words_before() or vim.api.nvim_get_mode().mode == "c" then
					return cmp.show()
				end
			end,
			"fallback",
		},
		["<S-Tab>"] = {
			"select_prev",
			function(cmp)
				if vim.api.nvim_get_mode().mode == "c" then
					return cmp.show()
				end
			end,
			"fallback",
		},
	},
})

-- autocmds
local autocommands = {
	highlightyank = {
		{
			event = "TextYankPost",
			desc = "Highlight yanked text",
			pattern = "*",
			callback = function()
				vim.hl.on_yank()
			end,
		},
	},
}

for group, commands in pairs(autocommands) do
	vim.api.nvim_exec("augroup " .. group, false)
	for _, cmd in ipairs(commands) do
		vim.api.nvim_create_autocmd(cmd.event, {
			pattern = cmd.pattern,
			desc = cmd.desc,
			callback = cmd.callback,
			group = group,
		})
	end
end
