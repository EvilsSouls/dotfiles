function re
  set recoverable_files (gtrash find | string replace -a -r '(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2})\t' '$1 $2  ' | string replace -r '^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}  )/home/evilssouls/' '$1~/' | string collect -N)
  set to_recover (echo $recoverable_files | fzf --reverse --multi --tac)

  if test (count $to_recover) -eq 0
    echo "error: no files selected"
    return
  end

  string replace -r '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}  ' '' $to_recover | string replace -r '^~/' '/home/evilssouls/' | xargs -o gtrash restore
end
