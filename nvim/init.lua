-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.loader.enable()

vim.o.number = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showmode = true
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.signcolumn = "no"
vim.o.splitright = true
vim.o.winborder = "rounded"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.fn.has("win32") == 1 then
end

vim.cmd.colorscheme("zhixu")

-- Space as leader key
vim.g.mapleader = vim.keycode("<Space>")

-- Split right when browsing man pages with K
vim.cmd("autocmd FileType man wincmd L")

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

-- NOTE: To install a plugin you just need to add the URL to the repository.
-- But as soon as you need to add more information, like the git branch or
-- commit, use the "plugin spec" form. See :help vim.pack

vim.pack.add({
	"https://github.com/folke/zen-mode.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-orgmode/orgmode",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/akinsho/toggleterm.nvim",
	-- "https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- ========================================================================== --
-- ==                         WRITING CONFIGURATION                         == --
-- ========================================================================== --

-- Writing defaults
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		vim.opt_local.showbreak = "↳ "
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb"
		vim.opt_local.conceallevel = 2
		vim.opt_local.textwidth = 0
		vim.opt_local.colorcolumn = "0"

		vim.opt_local.formatoptions:remove({ "c", "r", "o" })

		-- Visual line navigation
		vim.keymap.set("n", "j", "gj", { buffer = true })
		vim.keymap.set("n", "k", "gk", { buffer = true })

		-- Spellchecking
		vim.keymap.set("n", "<leader>ss", "<cmd>setlocal spell!<cr>", { buffer = true, desc = "Toggle spellcheck" })
		vim.keymap.set("n", "zg", "zg", { buffer = true, desc = "Add word to dictionary" })
		vim.keymap.set("n", "zw", "zw", { buffer = true, desc = "Mark word as incorrect" })
		vim.keymap.set("n", "z=", "z=", { buffer = true, desc = "Spelling suggestions" })
	end,
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --
require("mini.ai").setup()
require("mini.bufremove").setup()
require("mini.completion").setup({ lsp_completion = { source_func = "omnifunc", auto_setup = false } })
require("mini.extra").setup()
require("mini.icons").setup({ style = "glyph" })
require("mini.jump").setup()
require("mini.notify").setup({ lsp_progress = { enable = false } })
require("mini.pairs").setup()
require("mini.snippets").setup({})
require("mini.surround").setup()
require("mini.statusline").setup()
require("oil").setup({ default_file_explorer = true })
require("orgmode").setup({
	org_agenda_files = "~/orgfiles/**/*",
	org_default_notes_file = "~/orgfiles/refile.org",
})
require("toggleterm").setup()
require("trouble").setup()
require("zen-mode").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	window = {
		delay = 0,
	},
	triggers = {
		-- Leader triggers
		{ mode = { "n", "x" }, keys = "<Leader>" },
		-- `[` and `]` keys
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },
		-- `g` key
		{ mode = { "n", "x" }, keys = "g" },
		-- Marks
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		-- Registers
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		-- Window commands
		{ mode = "n", keys = "<C-w>" },
		-- `z` key
		{ mode = { "n", "x" }, keys = "z" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		{ mode = "n", keys = "<Leader>b", desc = "+Buffers" },
		{ mode = "n", keys = "<Leader>f", desc = "+Find" },
		{ mode = "n", keys = "<Leader>o", desc = "+Org" },
		{ mode = "n", keys = "<Leader>u", desc = "+Ui" },
		{ mode = "n", keys = "<Leader>t", desc = "+Terminal" },
		{ mode = "n", keys = "<Leader>x", desc = "+Trouble" },
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

-- Treesitter setup
-- Try to update all parsers after a plugin update
vim.api.nvim_create_autocmd("PackChanged", {
	pattern = "nvim-treesitter",
	desc = "Update treesitter parsers",
	command = "TSUpdate",
})

-- NOTE: treesitter features **must** be enabled manually
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-features
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "vim", "help", "c", "rust" },
	callback = function()
		-- Enable treesitter based syntax highlight
		pcall(vim.treesitter.start)
	end,
})

-- Conform setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "indent" },
	},
	formatters = {
		indent = {
			prepend_args = { "-linux" },
		},
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- LSP setup
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	desc = "LSP actions",
-- 	callback = function(event)
-- 		local opts = { buffer = event.buf }
-- 		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
-- 		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
-- 		vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
-- 		vim.keymap.set({ "n", "x" }, "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
--
-- 		local id = vim.tbl_get(event, "data", "client_id")
-- 		local client = id and vim.lsp.get_client_by_id(id)
--
-- 		if client and client:supports_method("textDocument/completion") then
-- 			vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
-- 		end
-- 	end,
-- })
--
-- vim.lsp.enable("clangd")

-- ========================================================================== --
-- ==                              KEYMAPS                                 == --
-- ========================================================================== --
-- Close buffer and preserve window layout
vim.keymap.set("n", "<leader>bc", "<cmd>lua pcall(MiniBufremove.delete)<cr>", { desc = "Close buffer" })

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste clipboard content" })

-- Terminal keybindings
vim.keymap.set("t", "JJ", "<C-\\><C-n>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizonal terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical terminal" })

-- Zen mode
vim.keymap.set("n", "<leader>uz", function()
	require("zen-mode").toggle({ window = { width = 0.55 } })
end, { desc = "Toggle Zen Mode" })

-- Better diagnostics list
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)

-- File explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Fuzzy finding
local FzfLua = require("fzf-lua")
vim.keymap.set("n", "<leader>fb", FzfLua.buffers, { desc = "Buffers" }) -- Buffers
vim.keymap.set("n", "<leader>fc", FzfLua.colorschemes, { desc = "Color Schemes" }) -- Color Schemes
vim.keymap.set("n", "<leader>fd", FzfLua.diagnostics_document, { desc = "Diagnostics" }) -- Diagnostics
vim.keymap.set("n", "<leader>ff", FzfLua.files, { desc = "Files" }) -- Files
vim.keymap.set("n", "<leader>fg", FzfLua.live_grep, { desc = "Grep" }) -- Live grep
vim.keymap.set("n", "<leader>fl", FzfLua.blines, { desc = "Lines" }) -- Lines in current buffer
vim.keymap.set("n", "<leader>fr", FzfLua.oldfiles, { desc = "Recent" }) -- Recent files
