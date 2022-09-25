[![Build Status](https://circleci.com/gh/AndrewRadev/popup_scrollbar.vim/tree/main.svg?style=shield)](https://circleci.com/gh/AndrewRadev/popup_scrollbar.vim?branch=main)

This is a loose port of <https://github.com/Xuyuanp/scrollbar.nvim> for upstream Vim with popup windows instead of floating windows. If you're interested in a Neovim version of the plugin, that's the original source anyway.

![Demo](http://i.andrewradev.com/cd73f8284361e2e91c44e32571b52848.gif)

## Usage

These three commands will enable, disable, and toggle the scrollbar:

``` vim
:PopupScrollbarEnable
:PopupScrollbarDisable
:PopupScrollbarToggle
```

The first one installs autocommands that automatically show the scrollbar when switching to a window and update its size and position. Disabling removes these autocommands and toggling switches between the two.

If you'd rather just have it enabled automatically, put the following in your vimrc:

``` vim
let g:popup_scrollbar_auto = 1
```

## Customizing

If you'd like to customize the size, shape, or color of the scrollbar, check the built-in help docs (`:help popup_scrollbar-settings`) for details. Here's a short summary of the default settings:

``` vim
let g:popup_scrollbar_max_size = 10
let g:popup_scrollbar_min_size = 3
let g:popup_scrollbar_shape = {
    \ 'head': '▲',
    \ 'body': '█',
    \ 'tail': '▼',
    \ }
let g:popup_scrollbar_highlight = 'PopupScrollbar'
highlight default link PopupScrollbar Normal
```

## Contributing

Pull requests are welcome, but take a look at [CONTRIBUTING.md](https://github.com/AndrewRadev/popup_scrollbar.vim/blob/main/CONTRIBUTING.md) first for some guidelines. Be sure to abide by the [CODE_OF_CONDUCT.md](https://github.com/AndrewRadev/popup_scrollbar.vim/blob/master/CODE_OF_CONDUCT.md) as well.
