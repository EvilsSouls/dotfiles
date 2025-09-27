function _run --description "Runs a command and ensures fish runs starship's"
  set -g OLD_COMMAND (commandline)
  commandline $argv

  set -g TRANSIENT 1
  set -g RIGHT_TRANSIENT 1
  commandline -f repaint
  commandline -f execute
end

