" VcsRoot/hg.vim: Get the Mercurial repository root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! VcsRoot#hg#Root()
    return VcsRoot#Generic#RootByCommandWithDirFallback('hg root', '.hg')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
