let s:save_cpo = &cpoptions
set cpoptions&vim

let s:timer = {'ids': {}}

function! s:timer.start(time, callback, ...) abort
  let options = get(a:, 1, {})
  return timer_start(a:time, a:callback, options)
endfunction

function! s:timer.stop(timer) abort
  return timer_stop(a:timer)
endfunction

function! s:timer.start_lazily(id, time, callback, ...) abort
  let timer_id = get(self.ids, a:id, -1)
  if timer_id != -1 | call self.stop(timer_id) | endif
  let self.ids[a:id] = self.start(a:time, a:callback, get(a:, 1, {}))
endfunction

function! iced#component#timer#start(_) abort
  call iced#util#debug('start', 'timer')
  return s:timer
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
