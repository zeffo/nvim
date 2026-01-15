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
vim.o.titlestring = "neovim"
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- length of time to wait before triggering the plugin
vim.o.virtualedit = "block" -- allow going past end of line in visual block mode
vim.o.wrap = false -- disable wrapping of lines longer than the width of window
vim.o.writebackup = false -- disable making a backup before overwriting a file
vim.opt.hlsearch = true -- do not persist search highlights
vim.opt.incsearch = true -- show matches while typing the search

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
vim.g.python3_host_prog = '/usr/bin/python'

-- plugins
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/rebelot/heirline.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	-- { src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" },
})

-- keymaps
vim.keymap.set("n", "H", vim.cmd.bprevious, { silent = true })
vim.keymap.set("n", "L", vim.cmd.bnext, { silent = true })
vim.keymap.set("n", "<leader>c", function()
	vim.cmd.bdelete()
end, { silent = true, noremap = true, desc = "Close current buffer" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "<C-H>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
vim.keymap.set("n", "<C-J>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
vim.keymap.set("n", "<C-K>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "Move to above split" })
vim.keymap.set("n", "<C-L>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", function()
	require("smart-splits").resize_up()
end, { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", function()
	require("smart-splits").resize_down()
end, { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", function()
	require("smart-splits").resize_left()
end, { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", function()
	require("smart-splits").resize_right()
end, { desc = "Resize split right" })

-- diagnostic
vim.diagnostic.config({
	underline = true,
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
})

-- lsp
vim.lsp.enable({
	"lua_ls",
	"stylua",
	"ruff",
	"ty",
	"gopls",
	"rust_analyzer",
})
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>xd", function()
	local items = vim.diagnostic.toqflist(vim.diagnostic.get(0))
	vim.fn.setqflist({}, " ", {
		title = "Diagnostics",
		items = items,
	})
	vim.cmd.copen()
end, { desc = "Add diagnostics to quickfix" })

-- splits
require("smart-splits").setup({
	ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
	ignored_buftypes = { "nofile" },
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
			TabLineSel = { fg = colors.crust, bg = colors.pink },
			TabLine = { fg = colors.overlay0, bg = colors.surface0 },
			MiniPickMatchCurrent = { bg = colors.peach, fg = colors.crust },
			MiniPickPromptPrefix = { fg = colors.pink },
			MiniPickPromptCaret = { fg = colors.pink },
		}
	end,
})
vim.cmd.colorscheme("catppuccin-mocha")
local colors = require("catppuccin.palettes").get_palette("mocha")

-- icons
-- require("gitsigns").setup()


-- treesitter
local ts = require("nvim-treesitter")
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if vim.list_contains(ts.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			vim.treesitter.start(args.buf)
		end
	end,
})

-- oil
require("oil").setup({
	default_file_explorer = true,
	columns = { "icon", "permissions", "size" },
	view_options = { show_hidden = true },
	keymaps = {
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-d>"] = { "actions.select", opts = { horizontal = true } },
		["<C-r>"] = "actions.refresh",
	},
})
vim.keymap.set("n", "<Leader>e", function()
	if vim.bo.filetype == "oil" then
		require("oil.actions").close.callback()
	else
		vim.cmd("Oil")
	end
end)

-- statusline
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local slbg = colors.base
local bfr_seps = { "", "" }
local char_missing = "•"
local tab_hl = utils.get_highlight("Tabline")
local tab_sel_hl = utils.get_highlight("TablineSel")
local mode_map = {
	n = { "Normal", colors.peach },
	v = { "Visual", colors.mauve },
	i = { "Insert", colors.pink },
	V = { "Visual Block", colors.yellow },
}

local function get_mode_color(mode)
	local m = mode_map[mode]
	local color = m and m[2] or colors.red
	return { fg = colors.crust, bg = color, bold = true }
end

local function pad_string(str, padding)
	padding = padding or {}
	return str and str ~= "" and string.rep(" ", padding.left or 1) .. str .. string.rep(" ", padding.right or 1) or ""
end

Spacer = function(r)
	return {
		provider = (" "):rep(r or 2),
		hl = { fg = slbg, bg = slbg },
	}
end

TablineSpacer = function(r)
	return {
		provider = (" "):rep(r or 1),
		hl = { fg = slbg },
	}
end

Fill = {
	provider = "%=",
	hl = { fg = slbg, bg = slbg },
}

local function make_pill(style, raw, opts)
	opts = opts or {}
	style = style or {}

	local LEFT = opts.left_sep or "─"
	local RIGHT = opts.right_sep or "─"

	local function eval(f, self)
		if type(f) == "function" then
			local ok, res = pcall(f, self)
			if ok then
				return res
			end
		end
		return f
	end

	local inner = { raw }

	return {
		init = function(self)
			if type(raw.init) == "function" then
				raw.init(self)
			end

			local rh = eval(raw.hl, self)
			if type(rh) ~= "table" then
				rh = {}
			end
			self._pill_raw_hl = rh

			local base_fg = rh.fg
			local base_bg = rh.bg

			self._pill = {
				sep_fg = style.fg or base_bg,
				sep_bg = style.bg or base_fg,

				raw_fg = style.bg or base_fg,
				raw_bg = style.fg or base_bg,

				bold = style.bold or rh.bold,
				italic = style.italic or rh.italic,
			}
		end,

		condition = raw.condition,

		{
			provider = LEFT,
			hl = function(self)
				local p = self._pill
				return {
					fg = p.sep_fg,
					bg = p.sep_bg,
				}
			end,
		},

		vim.tbl_extend("force", {
			hl = function(self)
				local p = self._pill
				return { fg = p.raw_fg, bg = p.raw_bg, bold = p.bold, italic = p.italic }
			end,
			condition = nil,
		}, inner),

		{
			provider = RIGHT,
			hl = function(self)
				local p = self._pill
				return {
					fg = p.sep_fg,
					bg = p.sep_bg,
				}
			end,
		},
	}
end

ModePill = make_pill(nil, {
	init = function(self)
		self.mode = vim.fn.mode(1)
		self.smode = self.mode:sub(1, 1)
		self.mode_color = get_mode_color(self.smode)
	end,
	provider = function(self)
		local m = mode_map[self.smode]
		local mode = m and m[1] or self.mode
		return pad_string("%2(" .. mode .. "%)")
	end,
	hl = function(self)
		return { bg = self.mode_color.bg, fg = slbg, bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}, { left_sep = bfr_seps[1] })

local FilePill = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FilePillName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return " [No Name] "
		end
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return pad_string(filename)
	end,
}
local FilePillFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "+",
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
	},
}

local FileSize = {

	provider = function()
		local function get_size()
			local suffix = { "b", "k", "M", "G", "T", "P", "E" }
			local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
			fsize = (fsize < 0 and 0) or fsize
			if fsize < 1024 then
				return fsize .. suffix[1]
			end
			local i = math.floor((math.log(fsize) / math.log(1024)))
			return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
		end
		return pad_string(get_size())
	end,
}

local LSPPill = make_pill({ fg = colors.yellow, bg = slbg, bold = true }, {
	update = { "LspAttach", "LspDetach" },

	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		if #names == 0 then
			return pad_string(char_missing)
		end
		return pad_string(table.concat(names, ", "))
	end,
}, { left_sep = bfr_seps[1] })

local GitDiffPill = make_pill({ fg = colors.surface0, bold = true }, {

	init = function(self)
		local s = vim.b.gitsigns_status_dict or {}
		self.added = s.added or 0
		self.removed = s.removed or 0
		self.changed = s.changed or 0
	end,
	{
		hl = { fg = colors.surface1 },
		{
			provider = function(self)
				return "+" .. self.added
			end,
			hl = function(self)
				if self.added > 0 then
					return { fg = colors.green }
				end
			end,
		},
		{
			provider = function(self)
				return " -" .. self.removed
			end,
			hl = function(self)
				if self.removed > 0 then
					return { fg = colors.red }
				end
			end,
		},
		{
			provider = function(self)
				return " ~" .. self.changed
			end,
			hl = function(self)
				if self.changed > 0 then
					return { fg = colors.yellow }
				end
			end,
		},
	},
}, { left_sep = bfr_seps[1] })

local DiagnosticsPill = make_pill({ fg = colors.surface0 }, {

	static = {
		error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR] .. "",
		warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN] .. "",
		info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO] .. "",
		hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT] .. "",
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		hl = { bold = true, fg = colors.surface1 },
		{
			provider = function(self)
				return self.error_icon .. self.errors .. " "
			end,
			hl = function(self)
				if self.errors > 0 then
					return { fg = colors.red }
				end
			end,
		},
		{
			provider = function(self)
				return self.warn_icon .. self.warnings .. " "
			end,
			hl = function(self)
				if self.warnings > 0 then
					return { fg = colors.yellow }
				end
			end,
		},
		{
			provider = function(self)
				return self.info_icon .. self.info .. " "
			end,
			hl = function(self)
				if self.info > 0 then
					return { fg = colors.teal }
				end
			end,
		},
		{
			provider = function(self)
				return self.hint_icon .. self.hints
			end,
			hl = function(self)
				if self.hints > 0 then
					return { fg = colors.sky }
				end
			end,
		},
	},
}, { right_sep = bfr_seps[2] })

local GitBranchPill = make_pill({ fg = colors.mauve, bg = slbg, bold = true }, {
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,

	provider = function(self)
		return pad_string(
			self.status_dict and (#self.status_dict.head > 1 and self.status_dict.head or "?") or char_missing
		)
	end,
}, { right_sep = bfr_seps[2] })

local TSPill = make_pill({ fg = colors.teal, bg = slbg, bold = true }, {
	init = function(self)
		self.parser = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
	end,
	provider = function(self)
		if self.parser ~= nil then
			return pad_string("TS")
		end
		return pad_string(char_missing)
	end,
})

local Ruler = {
	provider = "%7(%l/%3L%):%2c %P ",
}

local ScrollBar = {
	static = {
		sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = colors.blue },
}

local ScrollPill = make_pill({ fg = colors.flamingo, bg = slbg, bold = true }, {
	Ruler,
	ScrollBar,
}, { right_sep = bfr_seps[2] })

FileStatPill = make_pill({ fg = colors.maroon, bg = slbg, bold = true }, {
	FileSize,
})

FilePill = make_pill({ fg = colors.red, bg = slbg, bold = true }, utils.insert(FilePill, FilePillFlags, FilePillName))

local statusline = {
	ModePill,
	FilePill,
	GitBranchPill,
	Spacer(),
	GitDiffPill,
	DiagnosticsPill,
	Fill,
	LSPPill,
	TSPill,
	FileStatPill,
	ScrollPill,
}

local TablineFileName = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		if self.is_active or self.is_visible then
			return { bold = true, italic = true, fg = tab_sel_hl.fg, bg = tab_sel_hl.bg }
		else
			return tab_hl
		end
	end,
}
local TablineFileFlags = {

	hl = function(self)
		if self.is_active or self.is_visible then
			return { bg = tab_sel_hl.bg, fg = tab_sel_hl.fg, bold = true }
		end
		return { bg = tab_hl.bg, fg = tab_hl.fg }
	end,
	{
		provider = function(self)
			if vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) then
				return "+ "
			else
				return " "
			end
		end,
	},
	{
		condition = function(self)
			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
		end,
		provider = function(self)
			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return "  "
			else
				return " "
			end
		end,
	},
}

local TablineFileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		if self.is_active or self.is_visible then
			return tab_sel_hl
		else
			return tab_hl
		end
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	TablineFileFlags,
	TablineFileName,
}

local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	{ provider = " " },
	{
		provider = "",
		hl = function(self)
			if self.is_visible or self.is_active then
				return { fg = colors.red, bold = true }
			else
				return { fg = colors.overlay0 }
			end
		end,
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
}

local TablineBufferBlock = utils.surround(bfr_seps, function(self)
	if self.is_active or self.is_visible then
		return tab_sel_hl.bg
	else
		return tab_hl.bg
	end
end, { TablineFileNameBlock, TablineCloseButton, TablineSpacer() })

local BufferLine = utils.make_buflist(
	{ TablineBufferBlock, TablineSpacer() },
	{ provider = " ", hl = { fg = colors.overlay0 } },
	{ provider = " ", hl = { fg = colors.overlay0 } }
)

local WinBars = {}

require("heirline").setup({
	statusline = statusline,
	tabline = BufferLine,
	winbar = WinBars,
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

-- pickers
local pick = require("mini.pick")

local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
		border = "rounded",
	}
end

pick.setup({
	source = { show = pick.default_show },
	mappings = {
		move_down = "<Tab>",
		move_up = "<S-Tab>",
		toggle_preview = "<C-CR>",
		toggle_info = "<C-H>",
	},
	window = {
		config = win_config,
		prompt_prefix = "  ",
	},
})

vim.keymap.set("n", "<leader>ff", function()
	pick.builtin.files()
end)
vim.keymap.set("n", "<leader>fw", function()
	pick.builtin.grep()
end)
vim.keymap.set("n", "<leader>f<CR>", function()
	pick.builtin.resume()
end)
vim.keymap.set("n", "<leader>fb", function()
	pick.builtin.buffers()
end)
vim.keymap.set("n", "<leader>fr", function()
	local items = {}
	vim.lsp.buf.references(nil, {
		on_list = function(o)
			for _, v in pairs(o.items) do
				table.insert(items, v)
			end
		end,
	})
	pick.start({ source = { items = items } })
end)

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
