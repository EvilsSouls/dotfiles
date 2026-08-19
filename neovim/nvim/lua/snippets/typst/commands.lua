return {
  s(
    {
      trig = "figure", ---@todo Check whether a better trigger should perhaps be used
      dscr = "Quickly insert different figures",
    },
    fmt(
      [[
        #figure(
          {},
          alt: "{}",
          caption: [{}]
        ) <{}>
      ]],
      {
        c(1, {
          sn(nil, fmt('image({})', { i(1, 'image.png') })),
          sn(nil, fmt(
            [[
              #table(
                columns: ({}),
                table.header(
                  {}
                ),
                {}
              )
            ]],
            {
              i(1, 'auto, auto'),
              d(2, function(argnodes)
                -- print(vim.inspect(argnodes[1]))
                local columns = #(require('utils.utils').split_str(argnodes[1][1], ",[ ]?"))

                local nodes = {}
                for i = 1, columns do
                  nodes[i] = i(i)
                end

                -- print(vim.inspect(string.rep('[{}]', columns, ', ')))

                return sn(nil, fmt(string.rep('[{}]', columns, ', '), nodes))
              end, {1}),
              -- d(3),
              i(3)
            }
          ))
        }),
        i(2, 'Figure Description'),
        i(3, 'Caption'),
        i(4, 'Reference')
      }
    )
  )
}
