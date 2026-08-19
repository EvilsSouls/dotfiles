return {
  s(
    {
      trig="today",
      dscr="Inserts the current date",
    },
    {
      c(1, {
        f(function() return os.date("%Y-%m-%d") end),
        f(function() return os.date("%Y-%m-%d %H:%M") end),
        f(function() return os.date("%Y-%m-%d %X") end),
        f(function() return os.date("%Y-%m-%d %a %H:%M") end),
        f(function() return os.date("%Y-%m-%d %a %X") end)
      })
    }
  ),

  s(
    {
      trig="test",
      dscr="A test snippet",
    },
    fmt(
      [[
          Hello world {} this is some more text
          Here {} I have some more text to insert
          And this is even more {}
        ]],
      {
        i(1, "'I have text here'"),
        i(2, "'is text with some more'"),
        f(
          function(argnodes)
            print(vim.inspect(argnodes))

            local str
            if type(argnodes[1][1]) == "table" then
              str = ""
            else
              str = argnodes[1][1]
            end
            return string.upper(str)
          end, {1}
        )
      }
    )
  )
}
