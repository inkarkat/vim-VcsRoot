" VcsRoot/Manual.vim: Set the repository's root manually.
"
" DEPENDENCIES:
"   - ingo/err.vim autoload script
"   - ingo/escape/file.vim autoload script
"   - ingo/fs/path.vim autoload script
"   - ingo/fs/path/split.vim autoload script
"
" Copyright: (C) 2018 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	002	24-May-2018	Finished implementation.
"	001	21-May-2018	file creation
let s:save_cpo = &cpo
set cpo&vim

function! s:Canonicalize( dirspec )
    " Additionally drop the trailing path separator.
    return substitute(ingo#fs#path#Canonicalize(a:dirspec), '\V\C' . escape(ingo#fs#path#Separator(), '\') . '\$', '', '')
endfunction
function! s:Apply( dirspec )
    augroup VcsRootManual
	execute printf('autocmd BufNewFile,BufRead %s call setbufvar(str2nr(expand("<abuf>")), "VcsRoot", %s)',
	\   ingo#escape#file#autocmdescape(ingo#fs#path#Combine(a:dirspec, '**')), string(a:dirspec)
	\)
    augroup END
endfunction

function! VcsRoot#Manual#Set( dirspec )
    let l:dirspec = s:Canonicalize(a:dirspec)

    if ! ingo#fs#path#split#StartsWith(l:dirspec, expand('%:p:h'))
	call ingo#err#Set('The current file is not inside ' . l:dirspec)
	return 0
    endif

    let b:VcsRoot = l:dirspec
    call s:Apply(l:dirspec)
    return 1
endfunction

function! s:ReadRootDirspecs()
    if ! filereadable(g:VcsRoot_RootStoreFilespec)
	return []
    endif

    return readfile(g:VcsRoot_RootStoreFilespec)
endfunction
function! s:DeleteRootDirspec( rootDirspecs, dirspec )
    return filter(a:rootDirspecs, 'v:val !=# a:dirspec')
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
function! s:GetDirspecFromArgumentOrVariable( dirspec )
    if empty(a:dirspec)
	if ! exists('b:VcsRoot')
	    call ingo#err#Set("Root wasn't set yet; must pass dirspec")
	    return ''
	endif

	return b:VcsRoot
    else
	return s:Canonicalize(a:dirspec)
    endif
endfunction

function! VcsRoot#Manual#Store( dirspec )
    let l:dirspec = s:GetDirspecFromArgumentOrVariable(a:dirspec)
    if empty(l:dirspec) | return 0 | endif

    if ! VcsRoot#Manual#Set(l:dirspec)
	return 0
    endif

    let l:rootDirspecs = s:DeleteRootDirspec(s:ReadRootDirspecs(), l:dirspec)
    call add(l:rootDirspecs, l:dirspec)
    return s:WriteRootDirspecs(l:rootDirspecs)
endfunction

function! VcsRoot#Manual#Unstore( dirspec )
    let l:dirspec = s:GetDirspecFromArgumentOrVariable(a:dirspec)
    if empty(l:dirspec) | return 0 | endif

    let l:rootDirspecs = s:ReadRootDirspecs()
    let l:originalDirspecNum = len(l:rootDirspecs)
    let l:resultDirspecs = s:DeleteRootDirspec(l:rootDirspecs, l:dirspec)

    if len(l:resultDirspecs) == l:originalDirspecNum
	call ingo#err#Set('Not in store: ' . l:dirspec)
	return 0
    endif

    if empty(l:resultDirspecs) && filereadable(g:VcsRoot_RootStoreFilespec)
	call ingo#err#Set('Failed to delete store at ' . g:VcsRoot_RootStoreFilespec)
	return (delete(g:VcsRoot_RootStoreFilespec) == 0)
    endif

    return s:WriteRootDirspecs(l:resultDirspecs)
endfunction

function! VcsRoot#Manual#ApplyStored()
    for l:rootDirspec in s:ReadRootDirspecs()
	call s:Apply(l:rootDirspec)
    endfor
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
