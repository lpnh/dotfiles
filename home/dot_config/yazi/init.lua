function Linemode:custom()
	local year = os.date("%Y")
	local time = (self._file.cha.mtime or 0) // 1

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%b %d %H:%M", time)
	else
		time = time and os.date("%b %d %Y", time) or ""
	end

	return ui.Line(string.format("%s", time))
end

require("mime-ext"):setup({
	fallback_file1 = true,
})

require("zoxide"):setup({
	update_db = true,
})
