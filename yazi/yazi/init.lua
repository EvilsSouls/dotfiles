require("full-border"):setup()

th.git = th.git or {}
th.git.ignored = ui.Style():fg("#343331")
th.git.untracked = ui.Style():fg("#1C6C66")
th.git.modified = ui.Style():fg("#D0A215")
th.git.added = ui.Style():fg("#879A39")
th.git.deleted = ui.Style():fg("#D14D41"):bold()
th.git.updated = ui.Style():fg("#D0A215")

require("git"):setup {
  -- Order of status signs showing in the linemode
  order = 1500,
}
-- Add Symlinks to Status Bars
Status:children_add(function(self)
  local h = self._current.hovered
  if h and h.link_to then
    return " -> " .. tostring(h.link_to)
  else
    return ""
  end
end, 3300, Status.LEFT)

-- Show user/group of files in status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    " ",
  }
end, 500, Status.RIGHT)
