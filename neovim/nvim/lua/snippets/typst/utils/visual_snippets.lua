-- A wrapper function is required to ignore the passed arguments
local function isInsideMath()
  return require('utils.typst').isInsideMath()
end

s = require('luasnip.nodes.snippet').S
sn = require('luasnip.nodes.snippet').SN
isn = require('luasnip.nodes.snippet').ISN
t = require('luasnip.nodes.textNode').T
i = require('luasnip.nodes.insertNode').I
f = require('luasnip.nodes.functionNode').F
c = require('luasnip.nodes.choiceNode').C
d = require('luasnip.nodes.dynamicNode').D
r = require('luasnip.nodes.restoreNode').R
events = require('luasnip.util.events')
k = require('luasnip.nodes.key_indexer').new_key
ai = require('luasnip.nodes.absolute_indexer')
extras = require('luasnip.extras')
l = require('luasnip.extras').lambda
rep = require('luasnip.extras').rep
p = require('luasnip.extras').partial
m = require('luasnip.extras').match
n = require('luasnip.extras').nonempty
dl = require('luasnip.extras').dynamic_lambda
fmt = require('luasnip.extras.fmt').fmt
fmta = require('luasnip.extras.fmt').fmta
conds = require('luasnip.extras.expand_conditions')
postfix = require('luasnip.extras.postfix').postfix
types = require('luasnip.util.types')
parse = require('luasnip.util.parser').parse_snippet
ms = require('luasnip.nodes.multiSnippet').new_multisnippet

--- Copied from https://ejmastnak.com/tutorials/vim-latex/luasnip
local get_visual = function(args, parent, _, user_args)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    local default_val = nil
    if user_args then
      vim.notify('Inside if condition: ' .. vim.inspect(user_args))
      default_val = user_args
    end
    vim.notify('Default Val: ' .. vim.inspect(default_val))
    return sn(nil, i(1, default_val))
  end
end

local M = {}

M.cancel_snippet = s({
  trig = 'can',
  dscr = 'Cancels the selected expression',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('cancel({})', { d(1, get_visual) }))

M.underbrace_snippet = s({
  trig = 'ubrc',
  dscr = 'Inserts an underbrace under the selected expression',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('underbrace({}, {})', { d(1, get_visual), i(2, 'n "Times"') }))

M.overbrace_snippet = s({
  trig = 'obrc',
  dscr = 'Inserts an overbrace under the seleced expression',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('overbrace({}, {})', { d(1, get_visual), i(2) }))

M.double_underline_snippet = s({
  trig = 'fund',
  dscr = 'Underline the selected expression twice',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('#final_underline(${}$)', { d(1, get_visual) }))

M.sqrt = s({
  trig = 'sq',
  dscr = 'Inserts a square root',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('sqrt({})', { d(1, get_visual) }))

M.frac = s({
  trig = 'fd',
  dscr = 'Inserts a fraction',
  snippetType = 'autosnippet',
  condition = isInsideMath,
}, fmt('({})/({})', { d(1, get_visual, nil, { user_args = { '1' } }), i(2) }))

return M
