# asyncomplete-racer.vim

Provide [Racer](https://github.com/racer-rust/racer) support for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim).

## Installation

* Install Rust source code and Racer (assuming you have already installed Rust via [rustup](https://www.rustup.rs/)):

```sh
rustup component add rust-src
cargo install racer
```

* Install this plugin and its dependencies: [async.vim](https://github.com/prabirshrestha/async.vim) and [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)
* Append your Vim configuration file:

```vim
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options())
```

## Configuration

This plugin can be further configured by passing a dictionary to `asyncomplete#sources#racer#get_source_options()` like this:

```vim
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options({
    \     'config': {
    \         'racer_path': ''
    \     }
    \ }))
```

| Option | Default Value | Explanation |
|---|---|---|
| config.racer_path | ```'racer'``` | Path to the `racer` binary. If `racer` cannot be found in `PATH`, you must specify this manually. |

## License

See [LICENSE](https://raw.githubusercontent.com/keremc/asyncomplete-racer.vim/master/LICENSE).
