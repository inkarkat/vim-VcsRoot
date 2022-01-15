" VcsRoot/hg.vim: Get the Mercurial repository root directory.
"
" DEPENDENCIES:
"   - ingo/compat.vim autoload script
"   - ingo/fs/path.vim autoload script
"   - ingo/system.vim autoload script
"
" Copyright: (C) 2013-2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
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
    let l:root = ingo#system#Chomped('cd ' . ingo#compat#shellescape(expand('%:p:h')) . '&& hg root')
    if v:shell_error != 0
	let l:root = ''
    endif

    if empty(l:root)
	" Fallback: Search upwards for the storage directory, and assume its in
	" the root dir.
	let l:hgDirspec = finddir('.hg', '.;')
	if ! empty(l:hgDirspec)
	    let l:root = fnamemodify(ingo#fs#path#Combine(l:hgDirspec, ''), ':p:h:h')
	endif
    endif

    return l:root
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
