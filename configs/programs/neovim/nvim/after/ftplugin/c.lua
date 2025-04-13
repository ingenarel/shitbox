--todo: (maybe?) open a pull request about adding my custom regexes in the b:matchwords to filetype plugins dir in nvim (possibly vim too)
--todo: figure out a way on ignoring comments || strings while still have the ability to do jump around with % WHILE keeping the cursor on the word.

-- vim.b.match_words = "^\\s*#\\s*if\\(\\|def\\|ndef\\)\\>:^\\s*#\\s*elif\\>:^\\s*#\\s*else\\>:^\\s*#\\s*endif\\>,".. -- (default regex)
vim.b.match_words = vim.b.match_words
    -- todo: figure out a way on how to wrap around the jump when there is no default:
    .. ",\\<switch\\>:\\<case\\>:\\<default\\>" -- (switches)
    .. ",\\(else\\s\\+\\)\\@<!if\\>:\\<else\\s\\+if\\>:\\<else\\(\\s\\+if\\)\\@!\\>" -- (if-else if-else statements)
    -- todo: add new data types as i learn them.
    -- todo: need to do all return statements. currently only jumps to the first return statement it finds
    .. ",\\<\\(int\\|float\\|double\\|char\\|bool\\|long\\|short\\|signed\\|unsigned\\)\\s+\\h\\+\\w*\\s*(.*)\\s*{:\\<return\\>" -- non void function definition and return.
    --TODO: fix goto.
    -- ",\\(<goto\\s\\+\\(\\h*\\w*\\)\\s*;\\)\\|\\(\\(\\h*\\w*\\)\\s*\\:\\s*\\<goto\\s\\+\\1\\s*;\\)"
    -- ",\\(\\h*\\w*\\)\\s*:\\s*\\<goto\\s\\+\\1\\s*;\\|\\<goto\\s\\+\\(\\h*\\w*\\)\\s*;\\s*\\1\\s*:\\s*"
    --currently only works one of the ways. need to somehow make it work both ways.
    -- ",\\<goto\\s\\+\\(\\h*\\w*\\)\\s*;:\\1\\s*\\:\\s*" --works when goto is stated first.
    -- ",\\(\\h*\\w*\\)\\s*\\:\\s*:\\<goto\\s\\+\\1\\s*;" -- works when goto is stated last.
    .. ",\\<goto\\s\\+\\(\\h*\\w*\\)\\s*;:\\1\\s*\\:\\s*\\|\\(\\h*\\w*\\)\\s*\\:\\s*:\\<goto\\s\\+\\1\\s*;"

vim.opt_local.matchpairs = "(:),{:},[:],<:>"
