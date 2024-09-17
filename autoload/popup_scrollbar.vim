function popup_scrollbar#Show() abort
  let total_lines   = line('$')
  let window_height = winheight(0)
  let bar_size = max([float2nr(window_height * window_height / total_lines), g:popup_scrollbar_min_size]) 

  if bar_size >= window_height
    return
  endif

  let current_line = line('w$') - window_height

  let content = [get(g:popup_scrollbar_shape, 'head', '▲')]
  let body = get(g:popup_scrollbar_shape, 'body', '█')
  let content += split(repeat(body, bar_size - 2), '\zs')
  let content += [get(g:popup_scrollbar_shape, 'tail', '▼')]

  let [win_row, win_col] = win_screenpos(0)
  let col = win_col + winwidth(0)
  let ratio = str2float(total_lines - window_height)
  let line = win_row + float2nr(floor((window_height - bar_size) * (current_line / ratio)))

  if exists('w:scrollbar_popup')
    call popup_close(w:scrollbar_popup)
  endif

  let w:scrollbar_popup = popup_create(content, #{
        \ line: line,
        \ col: col,
        \ maxwidth: 1,
        \ maxheight: len(content),
        \ highlight: g:popup_scrollbar_highlight,
        \ })
endfunction

function! popup_scrollbar#Hide() abort
  if exists('w:scrollbar_popup')
    call popup_close(w:scrollbar_popup)
    unlet w:scrollbar_popup
  endif
endfunction
