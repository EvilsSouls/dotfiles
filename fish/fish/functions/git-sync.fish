function git-sync -w "git commit"
  git add .
  git commit -m $argv
  git push
end
