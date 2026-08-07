GREEK_SYMBOLS = {
  "alpha",
  "beta",
  "gamma",
  "delta",
  "epsilon",
  "zeta",
  "eta",
  "theta",
  "iota",
  "kappa",
  "lambda",
  "mu",
  "nu",
  "xi",
  "omicron",
  "pi",
  "rho",
  "sigma",
  "tau",
  "upsilon",
  "phi",
  "chi",
  "psi",
  "omega"
}

local function returnGreekSymbolSnippet(letter)
  local lowerCaseSnippet = s(
    {trig=";" .. string.sub(letter, 1, 1), snippetType="autosnippet"},
    {t(letter)}
  )

  local upperCaseSnippet = s(
    {trig=";" .. string.upper(string.sub(letter, 1, 1)), snippetType="autosnippet"},
    {t(string.upper(string.sub(letter, 1,1)) .. string.sub(letter, 2))}
  )

  return lowerCaseSnippet, upperCaseSnippet
end

local function returnAllGreekSymbolSnippets()
  local snips = {}

  for i = 1, #GREEK_SYMBOLS do
    local snip1, snip2 = returnGreekSymbolSnippet(GREEK_SYMBOLS[i])
    table.insert(snips, snip1)
    table.insert(snips, snip2)
  end

  return snips
end

return returnAllGreekSymbolSnippets()
