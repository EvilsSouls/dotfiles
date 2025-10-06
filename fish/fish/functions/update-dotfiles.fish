function update-dotfiles -w "git commit"
  cd $HOME/dotfiles
  git add .
  git commit
  git push
end
