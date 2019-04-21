" vim:tabstop=2:shiftwidth=2:expandtab:textwidth=99
" Vimwiki support for having your wiki directory as a git repo.

" We add to the vimwiki group
augroup vimwiki
  " Make sure this window's working dir is the wiki repo dir whenever home.md is opened
  au! BufRead ~/vimwiki/home.md lcd ~/vimwiki
  " Also do a git pull whenever home.md is opened
  au BufRead ~/vimwiki/home.md !git pull
  " After writing to any file in the wiki dir, add all files in the repo, commit and push
  au! BufWritePost ~/vimwiki/* !git add .;git commit -m "Autocommit and push";git push
augroup END

