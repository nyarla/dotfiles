" vim:et:sw=2:ts=2

function! s:on_load_pre()
  let g:lsp_signs_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_signs_error   = {'text': '☹'}
  let g:lsp_signs_warning = {'text': '☹'}
  let g:lsp_signs_hint    = {'text': '☺'}
endfunction

function! s:on_load_post()
  if executable('bash-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'bash-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
      \ 'whitelist': ['sh', 'bash'],
      \ })
  endif

  if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'css-languageserver',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
      \ 'whitelist': ['css', 'less', 'sass'],
      \ })
  endif

  if executable('docker-langserver')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
      \ 'whitelist': ['dockerfile'],
      \ })
  endif

  if executable('gopls')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'golang-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'gopls']},
      \ 'whitelist': ['go'],
      \ })
  endif

  if executable('vscode-json-languageserver')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'purescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vscode-json-languageserver --stdio']},
      \ 'whitelist': ['json'],
      \ })
  endif

  if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['javascript', 'javascript.jsx'],
      \ })
  endif
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['github.com/rabirshrestha/async.vim']
endfunction
