local isInsideMath = require('utils.typst').isInsideMath
local jsregexp_compile_safe = require("luasnip.util.jsregexp")

---@todo Very often the triggers have been waaaay to overcomplicated.
--- Like... can't I literally just use brackets *every single time* I
--- press `_`? Or what about the snippet transform v12 into v_(1). Are
--- The Brackets really necessary? Not to mention the horrible spaghetti
--- that is escaping out of the bracket

return {
  s(
    {
      trig        = '([ $][^%s]-)([_^])',
      snippetType = 'autosnippet',
      dscr        = 'Automatically inserts braces when entering sub- or supscript mode',
      trigEngine  = 'pattern',
      condition   = isInsideMath
    },
    fmt(
      "{}{}({})",
      {
        f(function(_, parent, _) return parent.captures[1] end),
        f(function(_, parent, _) return parent.captures[2] end),
        i(1)
      }
    )
  ),

  s(
    {
      trig        = '(%a+[)}]*)([0-9])',
      snippetType = 'autosnippet',
      dscr        = 'Automatically transforms digits after variables into indices.',
      trigEngine  = 'pattern',
      condition   = isInsideMath
    },
    fmt(
      "{}_({}{})",
      {
        f(function(_, parent, _) return parent.captures[1] end),
        f(function(_, parent, _) return parent.captures[2] end),
        i(1)
      }
    )
  ),

  s(
    {
      trig        = '([a-zA-Z])([_^])\\(([a-zA-Z\\d]+) ',
      snippetType = 'autosnippet',
      dscr        = 'Automatically escapes a subscript expression',
      -- Basically almost a one-to-one copy of the built-in ecma trigger engine, with the exception of
      -- using the entire line --- not just the line up to the cursor
      trigEngine  = function(trigger, opts)
        local trig_compiled, err_maybe = jsregexp_compile_safe(trigger .. "$", "")
        if not trig_compiled then
          error(("Error while compiling regex: %s"):format(err_maybe))
        end

        local pos_lookahead = opts.pos_lookahead
        local pos_lookahead_trig_compiled, pos_lookahead_err_maybe = jsregexp_compile_safe(pos_lookahead, "")
        if not pos_lookahead_trig_compiled then
          error(("Error while compiling regex: %s"):format(pos_lookahead_err_maybe))
        end

        return function(line_to_cursor, _)
          local line_text = vim.api.nvim_get_current_line()

          -- get first (and very likely only, since we appended the "$") match.
          local match = trig_compiled:exec(line_to_cursor)
          if match then
            local pos_lookahead_match = pos_lookahead_trig_compiled:exec(line_text:sub(match.index + #match[0]))

            if pos_lookahead_match then
            -- return full match, and all groups.
            local groups = {}
            for group_idx, capture in ipairs(match) do
              groups[group_idx] = capture
            end

            for _, capture in ipairs(pos_lookahead_match) do
              groups[#groups+1] = capture
            end

            groups.pos_lookahead_match = pos_lookahead_match[0]
            vim.notify(vim.inspect(pos_lookahead_match[0]))
            vim.notify(vim.inspect(line_to_cursor))
            vim.api.nvim_set_current_line(line_to_cursor)

            return line_to_cursor:sub(match.index), groups
          else
            return nil
            end
          end
        end
      end,
      trigEngineOpts = {
        pos_lookahead = "\\)(( \\S.*)?|([)$]))$"
      },
      condition = isInsideMath
    },

    fmt(
      "{}{}({}) {}{}",
      {
        f(function(_, parent, _) return parent.captures[1] end),
        f(function(_, parent, _) return parent.captures[2] end),
        f(function(_, parent, _) return parent.captures[3] end),
        i(0),
        f(function(_, parent, _) return parent.captures[4] end)
      }
    )
  )
}
