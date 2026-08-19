GREEK_SYMBOLS = {
  "alpha",
  "beta",
  "gamma",
  "delta",
  {"epsilon", "eta"},
  "zeta",
  "theta",
  "iota",
  "kappa",
  "lambda",
  "mu",
  "nu",
  "xi",
  "omicron",
  {"pi", "phi", "psi"},
  "rho",
  "sigma",
  "tau",
  "upsilon",
  "chi",
  "omega"
}

local function returnGreekSymbolSnippet(letter)
  local lowerCaseSnippet
  local upperCaseSnippet

  if type(letter) == "string" then
    lowerCaseSnippet = s(
      {trig=";" .. string.sub(letter, 1, 1), snippetType="autosnippet"},
      {t(letter)}
    )

    upperCaseSnippet = s(
      {trig=";" .. string.upper(string.sub(letter, 1, 1)), snippetType="autosnippet"},
      {t(string.upper(string.sub(letter, 1, 1)) .. string.sub(letter, 2))}
    )
  elseif type(letter) == "table" then
    local lower_case_choices = {}
    local upper_case_choices = {}

    for index = 1, #letter do
      lower_case_choices[index] = {t(letter[index]), i(1)}
      upper_case_choices[index] = {t(string.upper(string.sub(letter[index], 1, 1)) .. string.sub(letter[index], 2)), i(1)}
      -- lower_case_choices[index] = t(letter[index])
      -- upper_case_choices[index] = t(string.upper(string.sub(letter[index], 1, 1)) .. string.sub(letter[index], 2))
    end

    lowerCaseSnippet = s(
      {trig=";" .. string.sub(letter[1], 1, 1), snippetType="autosnippet"},
      {c(1, lower_case_choices)}
    )

    upperCaseSnippet = s(
      {trig=";" .. string.upper(string.sub(letter[1], 1, 1)), snippetType="autosnippet"},
      {c(1, upper_case_choices)}
    )
  end

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
