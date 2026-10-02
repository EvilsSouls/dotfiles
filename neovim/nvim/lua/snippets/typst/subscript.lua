-- A wrapper function is required to ignore the passed arguments
local function isInsideMath()
  return require('utils.typst').isInsideMath()
end

return {
  s(
    {
      trig = '([ $][^%s]-)([_^])',
      snippetType = 'autosnippet',
      dscr = 'Automatically inserts braces when entering sub- or supscript mode',
      trigEngine = 'pattern',
      condition = isInsideMath,
    },
    fmt('{}{}({})', {
      f(function(_, parent, _)
        return parent.captures[1]
      end),
      f(function(_, parent, _)
        return parent.captures[2]
      end),
      i(1),
    })
  ),

  s(
    {
      trig = '(%a+[)}]*)([0-9])',
      snippetType = 'autosnippet',
      dscr = 'Automatically transforms digits after variables into indices.',
      trigEngine = 'pattern',
      condition = isInsideMath,
    },
    fmt('{}_{}{}', {
      f(function(_, parent, _)
        return parent.captures[1]
      end),
      f(function(_, parent, _)
        return parent.captures[2]
      end),
      i(1),
    })
  ),
}
