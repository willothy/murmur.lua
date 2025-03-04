local M = {}

M.config = {}

function M.get(hlgroup_name, attr)
	local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
	local hex = vim.fn.synIDattr(hlgroup_ID, attr)
	return hex ~= "" and hex or "NONE"
end

function M.setup(all, current)
	if current then
		M.config.current = current
	elseif M.config.current and all == nil then
		current = M.config.current
	end
	if all then
		M.config.all = all
	elseif M.config.all then
		all = M.config.all
	end
	if type(all) == table then
		if type(all.guibg) ~= "string" then
			all.bg = "#393939"
		elseif all.guibg:sub(1, 1) ~= "#" and vim.fn.hlexists(all.guibg) == 1 then
			all.bg = M.get(all.guibg, "bg")
		end
		if type(all.guifg) ~= "string" then
			all.fg = "NONE"
		elseif all.guifg:sub(1, 1) ~= "#" and vim.fn.hlexists(all.guifg) == 1 then
			all.fg = M.get(all.guifg, "fg")
		end
	elseif type(all) == "string" and vim.fn.hlexists(all) == 1 then
		all = { link = all }
	else
		all = { fg = "NONE", bg = "#393939" }
	end

	if type(current) == "table" then
		if type(current.guibg) ~= "string" then
			current.bg = "#393939"
		elseif current.guibg:sub(1, 1) ~= "#" and vim.fn.hlexists(current.guibg) == 1 then
			current.bg = M.get(current.guibg, "bg")
		end
		if type(current.guifg) ~= "string" then
			current.fg = "NONE"
		elseif current.guifg:sub(1, 1) ~= "#" and vim.fn.hlexists(current.guifg) == 1 then
			current.fg = M.get(current.guifg, "fg")
		end
	elseif type(current) == "string" and vim.fn.hlexists(current) == 1 then
		current = { link = current }
	else
		current = all
	end
	if M.all.guibg then
		M.all.bg = M.all.guibg
		M.all.guibg = nil
	end
	if M.all.guifg then
		M.all.fg = M.all.guifg
		M.all.guifg = nil
	end
	if M.current.guibg then
		M.current.bg = M.current.guibg
		M.current.guibg = nil
	end
	if M.current.guifg then
		M.current.fg = M.current.guifg
		M.current.guifg = nil
	end
	M.all = all
	M.current = current
end

function M.create_highlights()
	if M.all then
		vim.api.nvim_set_hl(0, "murmur_cursor_rgb", M.all)
	end
	if M.current then
		vim.api.nvim_set_hl(0, "murmur_cursor_rgb_current", M.current)
	end
end

return M
