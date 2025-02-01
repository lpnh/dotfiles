return {
	entry = function()
		local home = os.getenv("HOME")
		local output, err = Command("cat")
			:arg(home .. "/.config/yazi/last_jump")
			:stdin(Command.INHERIT)
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:spawn()
			:wait_with_output()

		if output.status.success then
			ya.manager_emit("cd", { output.stdout })
		end
	end,
}
