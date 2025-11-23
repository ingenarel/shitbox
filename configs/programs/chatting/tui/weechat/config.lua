weechat.register("test_lua", "ingenarel", "1.0", "GPL3", "Test script", "", "")
weechat.print("", "Hello, from lua script!")

for _, plugin in ipairs({
	"aesthetic.py",
	"aformat.py",
	"atcomplete.pl",
	"autosort.py",
	"cmdind.pl",
	"colorize_nicks.py",
	"emoji.lua",
	"go.py",
	"lnotify.py",
	"vimode.py",
}) do
	weechat.print("", "Hello, from lua script!" .. plugin)
	weechat.command("", "/script install " .. plugin)
	weechat.command("", "/script load " .. plugin)
end
