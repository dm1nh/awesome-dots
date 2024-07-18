local M = {}

function M.pretty_path(opts)
	opts = vim.tbl_extend("force", {
		length = 4,
	}, opts or {})

	-- relative path
	local path = vim.fn.expand("%:~:.")
	local sep = package.config:sub(1, 1)
	local parts = vim.split(path, sep)

	if #parts <= opts.length then
		return path
	else
		return table.concat({
			parts[1],
			"…",
			unpack(parts, #parts - opts.length + 2, #parts),
		}, sep)
	end
end

return M
