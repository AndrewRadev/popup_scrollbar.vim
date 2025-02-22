function popup_scrollbar#Show() abort
  let total_lines   = line('$')
  let window_height = winheight(0)
  if total_lines <= window_height
    return
  endif

  let ratio = (total_lines - window_height) * 1.0
  let current_line = line('w$') - window_height
  let bar_size = float2nr(ceil(window_height * window_height / ratio))
  let bar_size = s:ClampSize(bar_size)

  let content = [get(g:popup_scrollbar_shape, 'head', '▲')]
  let body = get(g:popup_scrollbar_shape, 'body', '█')
  let content += split(repeat(body, bar_size - 2), '\zs')
  let content += [get(g:popup_scrollbar_shape, 'tail', '▼')]

  let [win_row, win_col] = win_screenpos(0)
  let col = win_col + winwidth(0)
  let line = win_row + float2nr(floor((window_height - bar_size) * (current_line / ratio)))

  if exists('b:scrollbar_popup') && b:scrollbar_popup > 0
    call popup_close(b:scrollbar_popup)
  endif

  let b:scrollbar_popup = popup_create(content, #{
        \ line: line,
        \ col: col,
        \ maxwidth: 1,
        \ maxheight: len(content),
        \ highlight: g:popup_scrollbar_highlight,
        \ zindex: 1,
        \ })
endfunction

function! popup_scrollbar#Hide() abort
  if exists('b:scrollbar_popup') && b:scrollbar_popup > 0
    call popup_close(b:scrollbar_popup)
    let b:scrollbar_popup = -1
  endif
endfunction

function s:ClampSize(size) abort
  if a:size < g:popup_scrollbar_min_size
    return g:popup_scrollbar_min_size
  elseif a:size > g:popup_scrollbar_max_size
    return g:popup_scrollbar_max_size
  else
    return a:size
  endif
endfunction
