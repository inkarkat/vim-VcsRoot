" VcsRoot.vim: Determine or set the repository's root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! VcsRoot#Root()
    if exists('b:VcsRoot')
	return b:VcsRoot
    endif

    try
	let b:VcsRoot = VcsRoot#{tolower(VCSCommandGetVCSType(bufnr('')))}#Root()
    catch /^Vim\%((\a\+)\)\=:E/
	throw ingo#msg#MsgFromVimException()   " Don't swallow Vimscript errors.
    catch
	" The VCSCommand function throws an exception when no VCS has been
	" detected.
	return ''
    endtry

    return b:VcsRoot
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
