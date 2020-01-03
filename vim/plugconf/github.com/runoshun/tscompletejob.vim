" vim:et:sw=2:ts=2

function! s:on_load_pre()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *before* a plugin is loaded.
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'filetype=typescript'
endfunction

function! s:depends()
  return []
endfunction
