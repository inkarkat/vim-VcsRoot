" VcsRoot.vim: Get the repository's root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	23-Mar-2013	file creation

function! VcsRoot#Root()
    if exists('b:VcsRoot')
	return b:VcsRoot
    endif

    try
	let b:VcsRoot = VcsRoot#{VCSCommandGetVCSType(bufnr(''))}#Root()
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
