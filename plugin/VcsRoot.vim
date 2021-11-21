" VcsRoot.vim: Determine or set the repository's root directory.
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

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_VcsRoot') || (v:version < 700)
    finish
endif
let g:loaded_VcsRoot = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:VcsRoot_RootStoreFilespec')
    let g:VcsRoot_RootStoreFilespec = $HOME . '/.vimroots'
endif


"- commands --------------------------------------------------------------------

command! -bar VcsRoot if empty(VcsRoot#Root()) | echoerr 'No root set' | else | echomsg VcsRoot#Root() | endif

command! -bar -nargs=1 -complete=dir RootSet
\   if ! VcsRoot#Manual#Set(<q-args>) | echoerr ingo#err#Get() | endif
command! -bar -nargs=? -complete=dir RootStore
\   if ! VcsRoot#Manual#Store(<q-args>) | echoerr ingo#err#Get() | endif
command! -bar -nargs=? -complete=customlist,VcsRoot#Manual#Complete RootUnstore
\   if ! VcsRoot#Manual#Unstore(<q-args>) | echoerr ingo#err#Get() | endif


"- autocmds --------------------------------------------------------------------

if filereadable(g:VcsRoot_RootStoreFilespec)
    call VcsRoot#Manual#ApplyStored()
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
