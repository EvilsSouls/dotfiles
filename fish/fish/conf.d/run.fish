function run_change_back --on-event fish_postexec
  if test -n "$OLD_COMMAND"
    commandline $OLD_COMMAND
    set -g OLD_COMMAND ""
  end
end
