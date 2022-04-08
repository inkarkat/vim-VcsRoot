" VcsRoot/git.vim: Get the Git repository root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! VcsRoot#git#Root()
    return VcsRoot#Generic#RootByCommandWithDirFallback('git rev-parse --show-toplevel', '.git')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
