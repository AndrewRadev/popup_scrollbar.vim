let s:visiblePopups = {}

function! Hide_current_popup(winid)
  if has_key(s:visiblePopups, a:winid)
    call popup_close(s:visiblePopups[a:winid])
  endif
endfunction

function! UpdatePopup(winid) abort
  call Hide_current_popup(a:winid)
  if (bufname() =~ 'fugitive')
    return 
  endif
  let total_lines   = line('$', a:winid)
  let window_height = winheight(a:winid)
  let bar_size = max([float2nr(window_height * window_height / total_lines), g:popup_scrollbar_min_size]) 

  if bar_size >= window_height
    return
  endif

  let current_line = line('w$', a:winid) - window_height

  let content = [get(g:popup_scrollbar_shape, 'head', '▲')]
  let body = get(g:popup_scrollbar_shape, 'body', '█')
  let content += split(repeat(body, bar_size - 2), '\zs')
  let content += [get(g:popup_scrollbar_shape, 'tail', '▼')]

  let [win_row, win_col] = win_screenpos(a:winid)
  let col = win_col + winwidth(a:winid)
  let ratio = str2float(total_lines - window_height)
  let line = win_row + float2nr(floor((window_height - bar_size) * (current_line / ratio)))

  call Hide_current_popup(a:winid)

  let s:visiblePopups[a:winid] = popup_create(content, #{
        \ line: line,
        \ col: col,
        \ maxwidth: 1,
        \ maxheight: len(content),
        \ highlight: g:popup_scrollbar_highlight,
        \ })
endfunction 

function! popup_scrollbar#Show() abort
    for winid in s:visiblePopups->keys()
        call UpdatePopup(winid)
    endfor
    call UpdatePopup(win_getid())
endfunction

function! popup_scrollbar#Hide() abort
  let winid = win_getid()
  call Hide_current_popup(winid)
  if has_key(s:visiblePopups, winid)
    call remove(s:visiblePopups, winid)
  endif
endfunction
