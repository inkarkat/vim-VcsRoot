" VcsRoot/Generic.vim: Generic VCS command / upwards directory search fallback implementation to get the VCS repository root directory.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	16-Jan-2022	file creation

function! VcsRoot#Generic#Root( vcsRootCommand, vcsMetaDirname )
    let l:root = ingo#system#Chomped('cd ' . ingo#compat#shellescape(expand('%:p:h')) . ' && ' . a:vcsRootCommand)
    if v:shell_error != 0
	let l:root = ''
    endif

    if empty(l:root)
	" Fallback: Search upwards for the storage directory, and assume it's in
	" the root dir.
	let l:dirspec = finddir(a:vcsMetaDirname, './;')
	if ! empty(l:dirspec)
	    let l:root = fnamemodify(ingo#fs#path#Combine(l:dirspec, ''), ':p:h:h')
	endif
    endif

    return l:root
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :