" VcsRoot/git.vim: Get the Git repository root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	003	16-Jan-2022	BUG: Need to 'cd' to the file's directory before
"				"git rev-parse" if 'autochdir' isn't set.
"				BUG: Fallback upwards search needs to start from
"				the file's directory (./), not the PWD (.).
"				BUG: finddir() (in Vim 8.2.2366) returns dirspec
"				with a trailing /, which requires two :h:h to
"				arrive at the parent directory. In Vim 7.4.1689,
"				there's no trailing /, but fnamemodify somehow
"				realizes that it's a directory and also requires
"				:h:h. Append a trailing / to the found
"				directory; fnamemodify() should recognize the
"				directory, anyway, but let's be safe here.
"				(Interestingly, all of this was correctly
"				implemented in hg.vim)
"				Refactoring: Extract generic
"				VcsRoot#Generic#RootByCommandWithDirFallback().
"	002	18-Jul-2014	FIX: Make VCS root dir detection work when CWD
"				is outside of the working copy.
"	001	22-Mar-2013	file creation

function! VcsRoot#git#Root()
    return VcsRoot#Generic#RootByCommandWithDirFallback('git rev-parse --show-toplevel', '.git')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
