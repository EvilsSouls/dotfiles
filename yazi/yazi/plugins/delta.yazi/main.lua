local function info(content)
  return ya.notify {
    title = "Delta",
    content = content,
    timeout = 5,
  }
end

local selected_path = ya.sync(function()
  for _, current_selected_file in pairs(cx.active.selected) do
    return current_selected_file.cache or current_selected_file
  end

  for i = 1, #cx.tabs do
    for _, current_selected_file in pairs(cx.tabs[i].selected) do
      return current_selected_file.cache or current_selected_file
    end
  end
end)

local hovered_path = ya.sync(function()
  local h = cx.active.current.hovered
  return h and h.path
end)

return {
  entry = function()
    local min_path, plu_path = selected_path(), hovered_path()

    ya.dbg(string.format("min_path: %s", min_path))
    ya.dbg(string.format("plu_path: %s", plu_path))

    if not min_path then
      return info("No file selected")
    elseif not plu_path then
      return info("No file hovered")
    end

    local permit = ui.hide()
    local child, err = Command("delta")
      :arg({ "--paging", "always" })
      :arg(tostring(min_path))
      :arg(tostring(plu_path))
      :stdout(Command.INHERIT)
      :spawn()

    if not child then
      ya.notify {title = "Deta", content = string.format("Failed to start `delta`, error: %s", err), timeout = 5, level = "error"}
      return
    end

    local status, err = child:wait()

    ya.dbg(string.format("Status: %s, Error: %s", status, err))

    permit:drop()
  end
}
