" VcsRoot/svn.vim: Get the Subversion repository root directory.
"
" DEPENDENCIES:
"   - ingo/fs/traversal.vim autoload script
"
" Copyright: (C) 2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	003	01-Aug-2013	ingo#fs#traversal#FindLastContainedInUpDir now
"				defaults to the current buffer's directory; omit
"				the argument.
"	002	26-Mar-2013	Rename to
"				ingo#fs#traversal#FindLastContainedInUpDir()
"	001	22-Mar-2013	file creation

function! VcsRoot#svn#Root()
    " Iterate upwards from CWD until we're in a directory without a .svn
    " directory.
    return ingo#fs#traversal#FindLastContainedInUpDir('.svn')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
