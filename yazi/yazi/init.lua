require("full-border"):setup()

-- Setup Spotter Menu
require('spot'):setup {
  metadata_section = {
    enable = true,
    hash_cmd = 'xxhsum', -- other hashing commands may be slower
    hash_filesize_limit = 150, -- in MB, set 0 to disable
    relative_time = true, -- 2026-01-01 or n days ago
    time_format = '%Y-%m-%d %H:%M', -- https://www.man7.org/linux/man-pages/man3/strftime.3.html
    show_compression = 'percentage', ---@type false|"size"|"percentage"
  },
  plugins_section = {
    enable = true,
  },
  style = {
    section = '#879A39',
    key = 'reset',
    value = '#878580',
    selected = '#878580',
    colorize_metadata = true,
    height = 30,
    width = 60,
    key_length = 15,
  },
}

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
