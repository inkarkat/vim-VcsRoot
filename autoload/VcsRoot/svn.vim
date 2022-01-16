" VcsRoot/svn.vim: Get the Subversion repository root directory.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	005	16-Jan-2022	BUG: Fallback upwards search needs to start from
"				the file's directory (./), not the PWD (.).
"				Append a trailing / to the found directory;
"				fnamemodify() should recognize the directory,
"				anyway, but let's be safe here.
"				Refactoring: Reuse extracted
"				VcsRoot#Generic#RootByUpwardsDirSearch().
"	004	18-Jul-2014	Support Subversion 1.7 repository layout with
"				only a single .svn directory inside the working
"				copy root.
"	003	01-Aug-2013	ingo#fs#traversal#FindLastContainedInUpDir now
"				defaults to the current buffer's directory; omit
"				the argument.
"	002	26-Mar-2013	Rename to
"				ingo#fs#traversal#FindLastContainedInUpDir()
"	001	22-Mar-2013	file creation

function! VcsRoot#svn#Root()
    let l:vcsMetaDirname = '.svn'
    if isdirectory(ingo#fs#path#Combine(expand('%:p:h'), l:vcsMetaDirname))
	" Detection for Subversion <= 1.6 (where there are .svn directories in
	" every directory of the working copy), or when in the working copy
	" root.

	" Iterate upwards from CWD until we're in a directory without a .svn
	" directory.
	return ingo#fs#traversal#FindLastContainedInUpDir(l:vcsMetaDirname)
    else
	" Detection for Subversion >= 1.7, where there's only a single .svn
	" directory in the working copy root.
	return VcsRoot#Generic#RootByUpwardsDirSearch(l:vcsMetaDirname)
    endif
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
