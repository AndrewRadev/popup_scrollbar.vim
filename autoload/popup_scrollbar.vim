function! popup_scrollbar#Show() abort
  let total_lines   = line('$')
  let window_height = winheight(0)
  if total_lines <= window_height
    return
  endif

  let ratio = window_height / (total_lines * 1.0)

  let bar_size = float2nr(ceil(window_height * ratio))
  let bar_size = s:ClampSize(bar_size)

  let content = [get(g:popup_scrollbar_shape, 'head', '▲')]
  let body = get(g:popup_scrollbar_shape, 'body', '█')
  let content += split(repeat(body, bar_size - 2), '\zs')
  let content += [get(g:popup_scrollbar_shape, 'tail', '▼')]

  let [win_row, win_col] = win_screenpos(0)

  let current_bottom_line = (line('w$') - window_height) * 1.0
  let popup_line_max = (window_height - bar_size) * 1.0
  let progress = current_bottom_line / (total_lines - window_height)

  let popup_line = win_row + float2nr(floor(popup_line_max * progress))
  let popup_col  = win_col + winwidth(0)

  if exists('w:scrollbar_popup') && w:scrollbar_popup > 0
    call popup_close(w:scrollbar_popup)
  endif

  let w:scrollbar_popup = popup_create(content, #{
        \ line: popup_line,
        \ col: popup_col,
        \ maxwidth: 1,
        \ maxheight: len(content),
        \ highlight: g:popup_scrollbar_highlight,
        \ zindex: 1,
        \ })
endfunction

function! popup_scrollbar#Hide() abort
  if exists('w:scrollbar_popup') && w:scrollbar_popup > 0
    call popup_close(w:scrollbar_popup)
    let w:scrollbar_popup = -1
  endif
endfunction

function s:ClampSize(size) abort
  if a:size < g:popup_scrollbar_min_size
    return g:popup_scrollbar_min_size
  elseif g:popup_scrollbar_max_size > 0 && a:size > g:popup_scrollbar_max_size
    return g:popup_scrollbar_max_size
  else
    return a:size
  endif
endfunction
