" VcsRoot/hg.vim: Get the Mercurial repository root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	003	16-Jan-2022	BUG: Fallback upwards search needs to start from
"				the file's directory (./), not the PWD (.).
"				Refactoring: Extract generic
"				VcsRoot#Generic#RootByCommandWithDirFallback().
"	004	17-Dec-2014	BUG: "chdir" command does not exist outside
"				Windows; use "cd" instead.
"				BUG: Fallback didn't account for trailing path
"				separator returned by finddir(); canonicalize
"				via ingo#fs#path#Combine(), and strip off an
"				additional fragment.
"	003	18-Jul-2014	FIX: Make VCS root dir detection work when CWD
"				is outside of the working copy.
"	002	08-Aug-2013	Move escapings.vim into ingo-library.
"	001	22-Mar-2013	file creation

function! VcsRoot#hg#Root()
    return VcsRoot#Generic#RootByCommandWithDirFallback('hg root', '.hg')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
