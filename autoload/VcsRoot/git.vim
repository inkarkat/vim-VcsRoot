" VcsRoot/git.vim: Get the Git repository root directory.
"
" DEPENDENCIES:
"   - ingo/system.vim autoload script
"
" Copyright: (C) 2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	22-Mar-2013	file creation

function! VcsRoot#git#Root()
    let l:root = ingo#system#Chomped('git rev-parse --show-toplevel')
    if v:shell_error != 0
	let l:root = ''
    endif

    if empty(l:root)
	" Fallback: Search upwards for the storage directory, and assume its in
	" the root dir.
	let l:gitDirspec = finddir('.git', ';')
	if ! empty(l:gitDirspec)
	    let l:root = fnamemodify(l:gitDirspec, ':p:h')
	endif
    endif

    return l:root
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
