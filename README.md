Vimwiki dir in a git repo
=========================

**Contents**

1. [General Flow](#general-flow)
2. [Current limitations and specific](#current-limitations-and-specific)
3. [Installation and setup](#installation-and-setup)
4. [Sample vimwiki config](#sample-vimwiki-config)

If you use [vim][] as your general editor, then [vimwiki][] could be a great
personal, or even public wiki tools for you.

Although [vimwiki][] is great to use on a single machine, it would be better to
have your wiki available on any machine or environment you work on. This is not
supported out of the box by [vimwiki][], but since the wiki files and data are
plain text files kept in disk based directories, making your wiki available
anywhere you go is simply a [git][] repo away.

The ideas here are not all my own, so many thanks to [Mark Dennehy][],
[Jarvist Moore Frost][], [Daniel Moerner][], [Manuel Dewald][] and some others
for the ideas and inspiration.

General Flow
------------

1. Initialize a git repo inside your `~/vimwiki` directory, and add some remote
   that you have acces to from other machines like a a Gitub, GitLab,
   Bitbucket, etc. repo. To do the first commit and push, you can add a
   `.gitignore` to ignore all vim swap files.
2. Whenever the main wiki index file is opened with [vimwiki][], we want to
   automatically do a `git pull` in the wiki directory to ensure we have the
   latest content from the remote. Opening the main index file will always take
   a bit longer due to this.
3. Whenever a file in the wiki changes, we want to:
    - add it to the git index
    - do a commit with a preset commit message
    - push the repo to the remote

This [vim][] plugin does the above by adding additional vim auto commands for
opening the main wiki index, and writing any wiki files inside the wiki dir.

Current limitations and specific
--------------------------------

I'm not very familiar with `vimscript` so for now this plugin is fairly much
hardcoded for my environment, specifically:
* I use vimwiki's `markdown` format for my wiki files, and specifically, I link
  mt wiki to a GitLab wiki repo, similar to what [Manuel Dewald][] describes on
  his page. This gives me the best of both world as far being able to use
  markdown, and also having my wiki directly abvailable and editable as both a
  GitLab and local vim wiki.  
  Since GitLab's main wiki entry page is called `home` instead of `index` like
  for vimwiki, I change my vimwiki setup to make my index page be called
  `home`, and this plugin is also hardcoded for that name.
* My wiki dir is the default `~/vimwiki` and this is also harcoded in the plugin.

Since both the vimwiki index name and installation dir is avaialble from the
vim wiki config, this plugin should in theory be able to pick it up from there
without having to hardcode these values. Unfortunately, my knowledge of is
vimscript does not yet cover how to do this. Please feel free to send me a PR
with these changes if you know how to do it.

Installation and setup
----------------------
1. Make sure you have [vimwiki][] installed using your [favourite][pg] vim
   plugin manager.
2. Configure vimwiki as per the docs. See my sample
   [vimwiki config][#sample-vimwiki-config] for ideas.
3. Manually create your `vimwiki` base dir as per your vimwiki setup.
4. Initialize a git repo in this dir, add a remote and make sure you can
   push/pull to the remote. As a simple test, add a `.gitignore` to ignore any
   vim swap files, add this to the repo and push.
3. Install this plugin using your [favourite][pg] vim plugin manager.
4. Restart vim and press `\ww` or `\wt` to open the wiki index. You should see
   a pause as a git pull is done. When saving any file in the wiki, you should
   see it add, commit and push the change. I have purposefully not made the git
   commands silent since I prefer to see them work than fail silently without
   notice. Change this if you prefer.

Sample vimwiki config
---------------------

This is a sample of my `vimwiki` config:
```vim
" Setup for vimwiki
"
" This file should be sourced from your .vimrc
"
"
" Set or override all/any options for personal wiki.
let wiki = {
\           'path': '~/vimwiki/',
\           'path_html': '~/vimwiki/HTML/',
\           'auto_export': 0,
\           'index': 'home',
\           'syntax': 'markdown',
\           'ext': '.md',
\           'auto_toc': 1,
\           'maxhi': 1,
\           'nested_syntaxes': {'python': 'python', 'js': 'javascript', 'c++': 'cpp'},
\           'list_margin': -1
\           }

" Make wiki the default vimwiki setup
let g:vimwiki_list = [wiki]
" When opening a directory containing a file with this name and default wiki
" extention, assume it is a vimwiki
let g:vimwiki_dir_link = ''
" Only treat .md files under a path in vimwiki_list as wiki files
let g:vimwiki_global_ext = 0
```

<!-- References -->
[vim]: http://vim.org 
[vimwiki]: https://github.com/vimwiki/vimwiki
[git]: https://git-scm.com/
[Mark Dennehy]: http://www.stochasticgeometry.ie/2012/11/23/vimwiki/
[Jarvist Moore Frost]: https://jarvistmoorefrost.wordpress.com/2014/06/25/snippet-console-diary-vimwiki-now-with-more-git-autohooks/
[Daniel Moerner]: https://dmoerner.wordpress.com/2017/08/14/vimwiki-and-git-autocommit/
[Manuel Dewald]: https://opensource.com/article/18/6/vimwiki-gitlab-notes
[pg]: https://github.com/tpope/vim-pathogen
