function Linemode:size_and_mtime()
	local year = os.date("%Y")
	local time = (self._file.cha.modified or 0) // 1

	-- if time > 0 and os.date("%Y", time) == year then
	-- 	time = os.date("%b %d %H:%M", time)
	-- else
	-- 	time = time and os.date("%b %d  %Y", time) or ""
	-- end
	time = os.date("%x-%I:%M:%S%p", time)

	local size = self._file:size()
	return ui.Line(string.format("%s|%s", size and ya.readable_size(size) or "-", time))
end
require("starship"):setup()
require("git"):setup()
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "cache_or_first" })
