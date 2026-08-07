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
  )
}
