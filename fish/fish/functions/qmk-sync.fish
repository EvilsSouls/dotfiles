function qmk-sync -w "qmk flash"
  qmk clean
  qmk flash $argv
end
