local isInsideMath = require('utils.typst').isInsideMath

return {
  s(
    {
      trig        = '(%a)vec',
      snippetType = 'autosnippet',
      dscr        = 'Automatically stacks an arrow on variable to signify a vector.',
      trigEngine  = 'pattern',
      condition   = isInsideMath
    },
    fmt(
      'arrow({})',
      {
        f(function(_, parent, _) return parent.captures[1] end),
      }
    )
  ),
}
