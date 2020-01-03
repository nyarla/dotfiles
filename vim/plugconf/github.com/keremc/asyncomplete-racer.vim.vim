" vim:et:sw=2:ts=2

function! s:on_load_pre()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *before* a plugin is loaded.
endfunction

function! s:on_load_post()
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options({
    \ 'name': 'racer',
    \ 'whitelist': ['rust'],
    \ 'completer': function('asyncomplete#sources#racer#completor'),
    \ 'config': { 'racer_path': 'racer' },
    \ }))
endfunction

function! s:loaded_on()
  return 'filetype=rust'
endfunction

function! s:depends()
  return ['github.com/rabirshrestha/asyncomplete.vim']
endfunction
