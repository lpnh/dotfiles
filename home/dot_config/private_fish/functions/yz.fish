# https://yazi-rs.github.io/docs/quick-start
function yz
	set cwd_file ~/.config/yazi/last_jump
	yazi $argv --cwd-file="$cwd_file"
	if set cwd (command cat -- "$cwd_file"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
end
