-- A wrapper function is required to ignore the passed arguments
local function isInsideMath()
  require('utils.typst').isInsideMath()
end

return {
  s(
    {
      trig = '(%a)vec',
      snippetType = 'autosnippet',
      dscr = 'Automatically stacks an arrow on variable to signify a vector.',
      trigEngine = 'pattern',
      condition = isInsideMath,
    },
    fmt('arrow({})', {
      f(function(_, parent, _)
        return parent.captures[1]
      end),
    })
  ),
}
