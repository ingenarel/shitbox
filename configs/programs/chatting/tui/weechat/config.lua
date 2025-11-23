weechat.register("test_lua", "ingenarel", "1.0", "GPL3", "Test script", "", "")
weechat.print("", "Hello, from lua script!")

for _, plugin in ipairs({ "autosort.py", "vimode.py", "atcomplete.pl", "cmdind.pl", "lnotify.py", "emoji.lua" }) do
	weechat.print("", "Hello, from lua script!" .. plugin)
	weechat.command("", "/script install " .. plugin)
	weechat.command("", "/script load " .. plugin)
end
