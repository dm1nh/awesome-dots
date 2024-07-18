local M = {}

local icons = require("config.defaults").icons

-- Components
-----------------------------------------------------------------------------------------------------------------------
function M.mode()
	return string.format("%s", vim.fn.mode())
end

function M.fileicon()
	local icon = ""
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if ok then
		icon = devicons.get_icon(vim.fn.expand("%:t"))
		if icon == nil then
			icon = devicons.get_icon_by_filetype(vim.bo.filetype)
		end

		if icon == nil then
			icon = ""
		end
	end
	return icon
end

function M.filename()
	return require("util.statusline").pretty_path()
end

local diagnostic_levels = {
	{ name = "ERROR", icon = icons.diagnostics.ERROR },
	{ name = "WARN", icon = icons.diagnostics.WARN },
	{ name = "INFO", icon = icons.diagnostics.INFO },
	{ name = "HINT", icon = icons.diagnostics.HINT },
}

function M.diagnostics()
	if not vim.diagnostic.is_enabled({ bufnr = 0 }) then
		return ""
	end

	local count = vim.diagnostic.count(0)
	local severity, t = vim.diagnostic.severity, {}

	for _, lvl in ipairs(diagnostic_levels) do
		local n = count[severity[lvl.name]] or 0

		if n > 0 then
			table.insert(t, lvl.icon .. " " .. n)
		end
	end

	if #t == 0 then
		return ""
	end

	return table.concat(t, " ")
end

function M.lsp()
	local attached = M.get_attached_lsp()
	if attached == "" or attached == nil then
		return ""
	end
	return "󱓞 " .. attached
end

function M.diff()
	return vim.b.gitsigns_status or ""
end

function M.branch()
	return vim.b.gitsigns_head ~= nil and icons.git.branch .. " " .. vim.b.gitsigns_head or ""
end

function M.location()
	local line = vim.fn.line(".")
	local col = vim.fn.virtcol(".")
	return string.format("%3d:%-2d", line, col)
end

-- utils
-----------------------------------------------------------------------------------------------------------------------

-- Manually decide if section needs to be truncated or not
---@param trunc_width? number
function M.is_truncated(trunc_width)
	local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
	return cur_width < (trunc_width or -1)
end

--- @param n? number
local function sep(n)
	n = n or 1
	return string.rep(" ", n)
end

-- utils for LSP
function M.get_attached_lsp()
	return M.attached_lsp[vim.api.nvim_get_current_buf()]
end
function M.get_lsp_clients(buf)
	return vim.lsp.get_clients({ bufnr = buf })
end

function M.compute_attached_lsp(buf)
	return string.rep("+", vim.tbl_count(M.get_lsp_clients(buf)))
end

-- Statusline
-----------------------------------------------------------------------------------------------------------------------
function M.active()
	return table.concat({
		sep(),
		M.mode(),
		sep(),
		M.fileicon(),
		sep(),
		M.filename(),
		sep(),
		M.diff(),
		sep(),
		M.diagnostics(),
		"%=",
		M.lsp(),
		sep(),
		M.location(),
		sep(),
		M.branch(),
		sep(),
	})
end

function M.inactive()
	return table.concat({
		sep(),
		M.filename(),
		"%=",
		M.branch(),
		sep(),
	})
end

function M.hide()
	return ""
end

M.disabled_filetypes = {
	"dashboard",
	"alpha",
	"starter",
	"NvimTree",
}

M.ensure_content = vim.schedule_wrap(function()
	-- NOTE: Use `schedule_wrap()` to properly work inside autocommands because
	-- they might temporarily change current window
	local cur_win_id, is_global_stl = vim.api.nvim_get_current_win(), vim.o.laststatus == 3
	for _, win_id in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.fn.winbufnr(win_id)
		local is_disable =
			vim.tbl_contains(M.disabled_filetypes, vim.api.nvim_get_option_value("filetype", { buf = buf }))

		if is_disable then
			vim.wo[win_id].statusline = "%{%v:lua.require'statusline'.hide()%}"
		elseif win_id == cur_win_id or is_global_stl then
			vim.wo[win_id].statusline = "%{%v:lua.require'statusline'.active()%}"
		else
			vim.wo[win_id].statusline = "%{%v:lua.require'statusline'.inactive()%}"
		end
	end
end)

M.attached_lsp = {}

function M.create_autocmds()
	local augroup = vim.api.nvim_create_augroup("Statusline", {})

	local au = function(event, pattern, callback, desc)
		vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
	end

	au({ "WinEnter", "BufWinEnter" }, "*", M.ensure_content, "Ensure statusline content")

	-- Use `schedule_wrap()` because at `LspDetach` server is still present
	local track_lsp = vim.schedule_wrap(function(data)
		M.attached_lsp[data.buf] = M.compute_attached_lsp(data.buf)
		vim.cmd("redrawstatus")
	end)
	au({ "LspAttach", "LspDetach" }, "*", track_lsp, "Track LSP clients")
end

function M.setup()
	M.create_autocmds()
	vim.go.statusline = "%{%v:lua.require'statusline'.active()%}"
end

return M
