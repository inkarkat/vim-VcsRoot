" VcsRoot/Manual.vim: Set the repository's root manually.
"
" DEPENDENCIES:
"
" Copyright: (C) 2018 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	21-May-2018	file creation
let s:save_cpo = &cpo
set cpo&vim

function! VcsRoot#Manual#Set( dirspec )
endfunction

function! s:Canonicalize( dirspec )
    return ingo#fs#path#Normalize(fnamemodify(a:dirspec, ':p')) " TODO: Move to ingo-library
endfunction
function! s:ReadRootDirspecs()
    if ! filereadable(g:VcsRoot_RootStoreFilespec)
	return []
    endif

    return readfile(g:VcsRoot_RootStoreFilespec)
endfunction
function! s:DeleteRootDirspec( rootDirspecs, dirspec )
    return filter(a:rootDirspecs, 'v:val !=# s:Canonicalize(a:dirspec)')
endfunction
function! s:WriteRootDirspecs( rootDirspecs )
    try
	call ingo#err#Set('Failed to write store at ' . g:VcsRoot_RootStoreFilespec)
	return (writefile(a:rootDirspecs, g:VcsRoot_RootStoreFilespec) == 0)
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

function! VcsRoot#Manual#Store( dirspec )
    let l:rootDirspecs = s:DeleteRootDirspec(s:ReadRootDirspecs(), a:dirspec)
    call append(l:rootDirspecs, s:Canonicalize(a:dirspec))
    return s:WriteRootDirspecs(l:rootDirspecs)
endfunction

function! VcsRoot#Manual#Unstore( dirspec )
    let l:rootDirspecs = s:ReadRootDirspecs()
    let l:originalDirspecNum = len(l:rootDirspecs)
    let l:resultDirspecs = s:DeleteRootDirspec(a:dirspec)

    if len(l:resultDirspecs) == l:originalDirspecNum
	call ingo#err#Set('Not in store: ' . a:dirspec)
	return 0
    endif

    if empty(l:resultDirspecs) && filereadable(g:VcsRoot_RootStoreFilespec)
	call ingo#err#Set('Failed to delete store at ' . g:VcsRoot_RootStoreFilespec)
	return (delete(g:VcsRoot_RootStoreFilespec) == 0)
    endif

    return s:WriteRootDirspecs(l:resultDirspecs)
endfunction

function! VcsRoot#Manual#Complete( ArgLead, CmdLine, CursorPos )
    let l:argLeadPattern = escape(a:ArgLead, '\')

    let l:rootDirspecs = s:ReadRootDirspecs()
    let l:filenameCandidates =
    \   filter(
    \       copy(l:rootDirspecs),
    \       'fnamemodify(v:val, ":t") =~ "\\V^" . l:argLeadPattern'
    \   )

    if ! empty(l:filenameCandidates)
	return l:filenameCandidates
    endif

    let l:allCandidates =
    \   filter(
    \       copy(l:rootDirspecs),
    \       'v:val =~ "\\V" . l:argLeadPattern'
    \   )

    return l:allCandidates
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
