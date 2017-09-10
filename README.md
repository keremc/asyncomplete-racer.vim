# asyncomplete-racer.vim

Provide [Racer](https://github.com/racer-rust/racer) support for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim).

## Installation

* Install Racer and the `rust-src` component:

```bash
rustup component add rust-src
cargo install racer
```

* Add this to your (Neo)vim configuration file:

```vim
" vim-plug
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'keremc/asyncomplete-racer.vim'

autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options())
```

## Configuration

If `racer` cannot be found in `PATH`, you must specify the path to it manually:

```vim
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options({
    \     'name': 'racer',
    \     'whitelist': ['rust'],
    \     'completor': function('asyncomplete#sources#racer#completor'),
    \     'config': {
    \         'racer_path': expand('~/.cargo/bin/racer')
    \     }
    \ }))
```

## License

See [LICENSE](https://raw.githubusercontent.com/keremc/asyncomplete-racer.vim/master/LICENSE).
