" vim:et:sw=2:ts=2

function! s:on_load_pre()
  function! LightLineMode()
    if &filetype ==# 'nerdtree'
      return 'NERDTree'
    endif

    return lightline#mode()
  endfunction

  function! LightLinePaste()
    return &paste ? "\uF429" : "" 
  endfunction

  function! LightLineReadonly()
    return &readonly ? "\uE0A2" : ""
  endfunction

  let g:lightline = {
    \ 'separator': {
    \   'left': "\uE0C0", 'right': "\uE0C2",
    \ },
    \ 'subseparator': {
    \   'left': "\uE0B1", 'right': "\uE0B3",
    \ },
    \ 'active' : {
    \   'left' : [
    \     ['mode', 'paste', 'readonly'],
    \     ['filetype', 'filename'],
    \   ],
    \   'right': [
    \     ['lineinfo', 'cocstatus'],
    \     ['fileformat'],
    \     ['charvaluehex'],
    \   ],
    \ },
    \ 'inactive': {
    \   'left': [ ['mode'] ],
    \   'right': [ [] ],
    \ },
    \ 'component': {
    \   'charvaluehex': 'U+%04B',
    \   'close': "%999X \uF00D"
    \ },
    \ 'component_function' : {
    \   'mode': 'LightLineMode',
    \   'paste': 'LightLinePaste',
    \   'readonly': 'LightLineReadonly',
    \   'fileformat': 'WebDevIconsGetFileFormatSymbol',
    \   'filetype': 'WebDevIconsGetFileTypeSymbol',
    \   'cocstatus': 'coc#status',
    \ },
    \ }
endfunction

function! s:on_load_post()
  hi! StatusLineNC guifg=#FDFDFD guibg=#5D5D5D
endfunction

function! s:loaded_on()
  " This function determines when a plugin is loaded.
  "
  " Possible values are:
  " * 'start' (a plugin will be loaded at VimEnter event)
  " * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
  " * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
  " <filetypes> and <excmds> can be multiple values separated by comma.
  "
  " This function must contain 'return "<str>"' code.
  " (the argument of :return must be string literal)

  return 'start'
endfunction

function! s:depends()
  return ['github.com/ryanoasis/vim-devicons', 'github.com/neoclide/coc.nvim']
endfunction
