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

require("frank"):setup {
	fzf = {
		[[--info-command 'echo -e "$FZF_INFO 💛"']],
		"--no-scrollbar --pointer '󰼛'",
	},
	rg = "--colors 'line:fg:red' --colors 'match:style:nobold'",
	rga = {
		"--hidden",
		"--follow",
		"--glob '!.git'",
	},
	fd = "--hidden",
	bat = "--style 'header,grid'",
	eza = "",
	eza_meta = "--total-size",
	rga_preview = {
		"--colors 'line:fg:red'"
			.. " --colors 'match:fg:blue'"
			.. " --colors 'match:bg:black'"
			.. " --colors 'match:style:nobold'",
	},
}

-- require("mime-ext"):setup {
-- 	fallback_file1 = true,
-- }

require("zoxide"):setup {
	update_db = true,
}
