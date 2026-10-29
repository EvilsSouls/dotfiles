-- A wrapper function is required to ignore the passed arguments
local function isInsideMarkup()
  return require('utils.typst').isInsideMarkup()
end

local function isInsideMath()
  return require('utils.typst').isInsideMath()
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

  s({
    trig = 'sr',
    dscr = 'Inserts ^2',
    snippetType = 'autosnippet',
    condition = isInsideMath,
    wordTrig = false,
  }, { t('^2') }),

  s({
    trig = 'cb',
    dscr = 'Inserts ^3',
    snippetType = 'autosnippet',
    condition = isInsideMath,
    wordTrig = false,
  }, { t('^3') }),

  s({
    trig = 'rd',
    dscr = 'Raise to (D)the power of',
    snippetType = 'autosnippet',
    condition = isInsideMath,
    wordTrig = false,
  }, { t('^') }),

  -- s({
  --   trig = 'fd',
  --   dscr = 'Inserts a fraction',
  --   snippetType = 'autosnippet',
  --   condition = isInsideMath,
  -- }, fmt('({})/({})', { i(1, '1'), i(2) })),

  -- s(
  --   {
  --     trig = 'invs',
  --     dscr = ''
  --   }
  -- ),

  s({
    trig = '+-',
    dscr = 'Insert a ±',
    snippetType = 'autosnippet',
    condition = isInsideMath,
  }, { t('plus.minus') }),

  s({
    trig = '-+',
    dscr = 'Insert a ∓',
    snippetType = 'autosnippet',
    condition = isInsideMath,
  }, { t('minus.plus') }),

  s(
    {
      trig = 'sqrt(uare',
      dscr = 'Inserts an actual square when typing "square"',
      snippetType = 'autosnippet',
      condition = isInsideMath,
    },
    { t('square') },
    -- Removes the excess bracket at the end of the insertion
    {
      callbacks = {
        [-1] = {
          [events.leave] = function()
            -- Has to wait a bit for the deletion to be done after the snippet insertion
            vim.defer_fn(function()
              local remove_next_char_keys = vim.api.nvim_replace_termcodes('<Esc>lx', true, false, true)
              vim.api.nvim_feedkeys(remove_next_char_keys, 'm', false)

              local cursor_loc = vim.fn.col('.')
              local current_line_length = #vim.api.nvim_get_current_line()

              -- If the cursor is on the last character of the line, then `a` must be pressed. Otherwise,
              -- if the snippet has been inserted in the middle of the line, `i` must be pressed since the
              -- cursor is one character to the right of the ending character of 'square'
              if cursor_loc == current_line_length then
                vim.api.nvim_feedkeys('a', 'm', false)
              else
                vim.api.nvim_feedkeys('i', 'm', false)
              end
            end, 0)
          end,
        },
      },
    }
  ),

  s({
    trig = 'limh',
    dscr = 'Inserts lim_(h -> 0)',
    snippetType = 'autosnippet',
    condition = isInsideMath,
  }, { t('lim_(h -> 0)') }),

  s(
    {
      trig = 'diffquot',
      dscr = 'Inserts the difference quotient of an arbitrary function',
      snippetType = 'autosnippet',
      condition = isInsideMath,
    },
    fmt([[({ifn}({ivar} + h) - {fn}({var}))/h]], {
      ifn = i(1, 'f'),
      ivar = i(2, 'x'),
      fn = rep(1),
      var = rep(2),
    })
  ),

  s(
    {
      trig = 'derivative',
      dscr = 'Inserts the definition of the derivative',
      condition = isInsideMath,
    },
    fmt([[{ifn}'({ivar}) = lim_(h -> 0) ({fn}({var} + h) - {fn}({var}))/h]], {
      ifn = i(1, 'f'),
      ivar = i(2, 'x'),
      fn = rep(1),
      var = rep(2),
    })
  ),

  s(
    {
      trig = 'quadeq',
      dscr = 'Inserts the quadratic formula',
      condition = isInsideMath,
    },
    fmt([[({ib} plus.minus sqrt({b}^2 - 4 {ia} {ic}))/(2{a})]], {
      ib = i(1, '-b'),
      ia = i(2, 'a'),
      ic = i(3, 'c'),
      b = rep(1),
      a = rep(2),
    })
  ),
}
