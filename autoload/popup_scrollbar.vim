function popup_scrollbar#Show() abort
    " echom 'popup_scrollbar#Show '
  let total_lines   = line('$')
  let window_height = winheight(0)
  let bar_size = max([float2nr(window_height * window_height / total_lines), g:popup_scrollbar_min_size]) 

  if bar_size >= window_height
    return
  endif

  let current_line = line('w$') - window_height
  " echom 'current_line = ' . current_line

  let content = [get(g:popup_scrollbar_shape, 'head', '▲')]
  let body = get(g:popup_scrollbar_shape, 'body', '█')
  let content += split(repeat(body, bar_size - 2), '\zs')
  let content += [get(g:popup_scrollbar_shape, 'tail', '▼')]

  let [win_row, win_col] = win_screenpos(0)
  let col = win_col + winwidth(0)
  let ratio = (total_lines - window_height) * 1.0
  let line = win_row + float2nr(floor((window_height - bar_size) * (current_line / ratio)))

  if exists('w:scrollbar_popup') && w:scrollbar_popup > 0
      " echom 'popup_close ' . w:scrollbar_popup
    call popup_close(w:scrollbar_popup)
  endif

  let w:scrollbar_popup = popup_create(content, #{
        \ line: line,
        \ col: col,
        \ maxwidth: 1,
        \ maxheight: len(content),
        \ highlight: g:popup_scrollbar_highlight,
        \ })
  " echom 'w:scrollbar_popup = ' . w:scrollbar_popup . ' win_h=' . window_height . ' total_lines=' . total_lines
endfunction

function! popup_scrollbar#Hide() abort
  if exists('w:scrollbar_popup')
    " echom 'popup_scrollbar#Hidea ' . w:scrollbar_popup
  else
    " echom 'popup_scrollbar#Hidea no w:scrollbar_popup'
  endif
  if exists('w:scrollbar_popup') && w:scrollbar_popup > 0
    call popup_close(w:scrollbar_popup)
    let w:scrollbar_popup = -1
  endif
endfunction
