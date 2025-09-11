local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Go snippets
ls.add_snippets('go', {
  -- fmt.Println()
  s('println', {
    t 'fmt.Println(',
    i(1),
    t ')',
  }),
})
