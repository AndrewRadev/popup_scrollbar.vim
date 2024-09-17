if !exists('#WinScrolled')
  finish
endif

if exists('g:loaded_popup_scrollbar') || &cp
  finish
endif

let g:loaded_popup_scrollbar = '0.0.1' " version number
let s:keepcpo = &cpo
set cpo&vim

if !exists('g:popup_scrollbar_auto')
  let g:popup_scrollbar_auto = 0
endif

if !exists('g:popup_scrollbar_max_size')
  let g:popup_scrollbar_max_size = 10
endif

if !exists('g:popup_scrollbar_min_size')
  let g:popup_scrollbar_min_size = 3
endif

if !exists('g:popup_scrollbar_shape')
  let g:popup_scrollbar_shape = {
        \ 'head': '▲',
        \ 'body': '█',
        \ 'tail': '▼',
        \ }
endif

if !exists('g:popup_scrollbar_highlight')
  let g:popup_scrollbar_highlight = 'PopupScrollbar'
endif

highlight default link PopupScrollbar Normal

let s:enabled = 0

command! PopupScrollbarEnable  call s:Enable()
command! PopupScrollbarDisable call s:Disable()
command! PopupScrollbarToggle  call s:Toggle()

function s:Enable() abort
  let s:enabled = 1

  augroup PopupScrollbar
    autocmd!
    autocmd WinScrolled,VimResized,QuitPre,WinEnter,FocusGained *
          \ call popup_scrollbar#Show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost *
          \ call popup_scrollbar#Hide()
  augroup END

  call popup_scrollbar#Show()
endfunction

function s:Disable() abort
  let s:enabled = 0

  augroup PopupScrollbar
    autocmd!
  augroup END

  call popup_scrollbar#Hide()
endfunction

function! s:Toggle() abort
  if s:enabled
    call s:Disable()
  else
    call s:Enable()
  endif
endfunction

if g:popup_scrollbar_auto
  call s:Enable()
endif

let &cpo = s:keepcpo
unlet s:keepcpo
