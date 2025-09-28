# Adapted from fish documentation
function expand_dots --description 'Changes ".." to "../", "..." to "../../", "...." to "../../..", etc.'
  echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
