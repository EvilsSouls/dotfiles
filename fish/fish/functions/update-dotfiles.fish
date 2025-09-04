function update-dotfiles
  cd $HOME/dotfiles
  git add .
  git commit -m $argv
  git push
end
