function! asyncomplete#sources#racer#get_source_options(...) abort
    return extend(extend({
        \     'name': 'racer',
        \     'completor': function('asyncomplete#sources#racer#completor'),
        \     'whitelist': ['rust']
        \ }, a:0 >= 1 ? a:1 : {}), {'refresh_pattern': '\k\+$'})
endfunction

function! asyncomplete#sources#racer#completor(opts, ctx) abort
    let config = get(a:opts, 'config', {})
    let racer_path = get(config, 'racer_path', 'racer')

    if !executable(racer_path)
        return
    endif

    let tmp_file = s:write_to_tmp_file()
    let start_column = s:get_start_column(a:ctx)

    let cmd = [racer_path, '--interface', 'tab-text', 'complete',
        \ string(a:ctx['lnum']), string(a:ctx['col'] - 1), a:ctx['filepath'], tmp_file]

    let matches = []

    call async#job#start(cmd, {
        \     'on_stdout': function('s:handler', [a:opts, a:ctx, start_column, matches]),
        \     'on_exit': function('s:handler', [a:opts, a:ctx, start_column, matches])
        \ })
endfunction

function! s:handler(opts, ctx, start_column, matches, job_id, data, event) abort
    if a:event == 'stdout'
        for line in a:data
            let fields = split(line, '\t')
            if len(fields) != 7 || fields[0] != 'MATCH'
                continue
            endif

            call add(a:matches, {'word': fields[1], 'menu': fields[6], 'dup': 1, 'icase': 1})
        endfor
    elseif a:event == 'exit'
        call asyncomplete#complete(a:opts['name'], a:ctx, a:start_column, a:matches)
    endif
endfunction

function! s:write_to_tmp_file() abort
    let file = tempname()
    call writefile(getline(1, '$'), file)
    return file
endfunction

function! s:get_start_column(ctx) abort
    let cur_column = a:ctx['col']
    let text_length = len(matchstr(a:ctx['typed'], '\k\+$'))
    return cur_column - text_length
endfunction
