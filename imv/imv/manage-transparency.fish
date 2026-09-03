#!/usr/bin/env fish

set file_path "$XDG_RUNTIME_DIR/imv-$imv_pid" 

if not test -e $file_path

  echo "dark_mode: true" > $file_path
  echo "transparency: true" >> $file_path
end

cat $file_path | awk "/dark_mode/ {print \$2}" | read dark_mode
cat $file_path | awk "/transparency/ {print \$2}" | read transparency

echo "dark_mode: $dark_mode"
echo "transparency: $transparency"

if $transparency
  if $dark_mode
    imv-msg $imv_pid "background #202020"
  else
    imv-msg $imv_pid "background #dddddd"
  end

  set -gx transparency false
else
  if $dark_mode
    imv-msg $imv_pid "background #00000099"
  else
    imv-msg $imv_pid "background checks"
  end

  set -gx transparency true
end

echo "dark_mode: $dark_mode" > $file_path
echo "transparency: $transparency" >> $file_path
