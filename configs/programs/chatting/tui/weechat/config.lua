weechat.register("test_lua", "ingenarel", "1.0", "GPL3", "Test script", "", "")
weechat.print("", "Hello, from lua script!")

local scripts = { "autosort.py", "vimode.py", "atcomplete.pl", "cmdind.pl", "lnotify.py", "emoji.lua" }
for scriptNumber = 1, #scripts do
	weechat.command(0, "/script install " .. scripts[scriptNumber])
	weechat.command(0, "/script load " .. scripts[scriptNumber])
end
