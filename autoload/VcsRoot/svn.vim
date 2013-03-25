" VcsRoot/svn.vim: Get the Subversion repository root directory.
"
" DEPENDENCIES:
"   - ingo/fstraversal.vim autoload script
"
" Copyright: (C) 2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	22-Mar-2013	file creation

function! VcsRoot#svn#Root()
    " Iterate upwards from CWD until we're in a directory without a .svn
    " directory.
    return ingo#fstraversal#FindLastContainedInUpDir('.svn', expand('%:p:h'))
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
