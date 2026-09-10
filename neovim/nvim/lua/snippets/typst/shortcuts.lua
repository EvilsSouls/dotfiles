-- A wrapper function is required to ignore the passed arguments
local function isInsideMarkup()
  require('utils.typst').isInsideMarkup()
end

return {
  s({
    trig = 'mk',
    dscr = 'Quick homerow trigger to type inline math',
    snippetType = 'autosnippet',
    condition = isInsideMarkup,
  }, { t('$'), i(1), t('$') }),

  s(
    {
      trig = 'dm',
      dscr = 'Quick homerow trigger to type display-mode math',
      snippetType = 'autosnippet',
      condition = isInsideMarkup,
    },
    fmta(
      [[
        $
          <>
        $
      ]],
      { i(1) }
    )
  ),
}
