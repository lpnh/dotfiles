function Linemode:custom()
	local year = os.date("%Y")
	local time = (self._file.cha.mtime or 0) // 1

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%d %b %H:%M", time)
	else
		time = time and os.date("%d %b %Y", time) or ""
	end

	return ui.Line(string.format("%s", time))
end

require("frank-nightly"):setup {
	fzf = {
		[[--info-command 'echo -e "$FZF_INFO 💛"']],
		"--no-scrollbar --pointer '󰼛'",
	},
	rg = "--colors 'line:fg:red' --colors 'match:style:nobold'",
	rga = {
		"--follow",
		"--hidden",
		"--glob '!.git'",
		"--glob '!node_modules'",
		"--word-regexp",
	},
	fd = "--hidden",
	bat = "",
	eza = "",
	eza_meta = "--total-size",
	rga_preview = {
		"--colors 'column:fg:black'"
			.. " --colors 'line:fg:black'"
			.. " --colors 'match:fg:black'"
			.. " --colors 'match:bg:blue'"
			.. " --colors 'match:style:nobold'"
			.. [[ --context-separator=" "]]
			.. [[ --field-context-separator=" "]]
			.. [[ --field-match-separator=" "]],
	},
}

require("mime-ext"):setup {
	fallback_file1 = true,
}

require("zoxide"):setup {
	update_db = true,
}
