function update-dotfiles -w "git commit"
  cd $HOME/dotfiles
  git add .
  git commit -m $argv
  git push
end
